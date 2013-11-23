#include "bot_ai.h"
#include "Group.h"
#include "Player.h"
#include "ScriptMgr.h"
#include "SpellAuras.h"
#include "WorldSession.h"
/*
Mage NpcBot (reworked by Graff onlysuffering@gmail.com)
Complete - Around 45%
TODO: Ice Lance, Deep Freeze, Mana Gems, Pet etc...
*/
class mage_bot : public CreatureScript
{
public:
    mage_bot() : CreatureScript("mage_bot") { }

    CreatureAI* GetAI(Creature* creature) const
    {
        return new mage_botAI(creature);
    }

    bool OnGossipHello(Player* player, Creature* creature)
    {
        return bot_minion_ai::OnGossipHello(player, creature);
    }

    bool OnGossipSelect(Player* player, Creature* creature, uint32 sender, uint32 action)
    {
        if (bot_minion_ai* ai = creature->GetBotMinionAI())
            return ai->OnGossipSelect(player, creature, sender, action);
        return true;
    }

    struct mage_botAI : public bot_minion_ai
    {
        mage_botAI(Creature* creature) : bot_minion_ai(creature) { }

        bool doCast(Unit* victim, uint32 spellId, bool triggered = false)
        {
            if (checkBotCast(victim, spellId, CLASS_MAGE) != SPELL_CAST_OK)
                return false;

            bool result = bot_ai::doCast(victim, spellId, triggered);

            if (result && spellId != MANAPOTION && me->HasAura(CLEARCASTBUFF))
            {
                cost = info->CalcPowerCost(me, info->GetSchoolMask());
                if (cost)
                    clearcast = true;
            }

            return result;
        }

        void EnterCombat(Unit*) { }
        void Aggro(Unit*) { }
        void AttackStart(Unit*) { }
        void KilledUnit(Unit*) { }
        void EnterEvadeMode() { }
        void MoveInLineOfSight(Unit*) { }
        void JustDied(Unit*) { master->SetNpcBotDied(me->GetGUID()); }

        void StartAttack(Unit* u, bool force = false)
        {
            if (GetBotCommandState() == COMMAND_ATTACK && !force) return;
            Aggro(u);
            SetBotCommandState(COMMAND_ATTACK);
            GetInPosition(force, true);
        }

        void Counter()
        {
            Unit* u = me->GetVictim();
            bool cSpell = COUNTERSPELL && CounterSpell_cd <= 5000;
            bool blast = FIREBLAST && FireBlast_cd <= 3000 && !(u && u->ToCreature() && (u->ToCreature()->isWorldBoss() || u->ToCreature()->IsDungeonBoss())) && me->HasAura(IMPACT_BUFF);
            if (!cSpell && !blast) return;
            if (u && u->IsNonMeleeSpellCasted(false) &&
                ((cSpell && me->GetDistance(u) < 30) || (blast && me->GetDistance(u) < 30)))
            {
                temptimer = GC_Timer;
                if (me->IsNonMeleeSpellCasted(false))
                    me->InterruptNonMeleeSpells(false);
                if (cSpell && doCast(u, COUNTERSPELL))
                    CounterSpell_cd = 15000;
                else if (blast && doCast(u, FIREBLAST))
                    FireBlast_cd = 6000;
                GC_Timer = temptimer;
            }
            else if (cSpell)
            {
                if (Unit* target = FindCastingTarget(30))
                {
                    temptimer = GC_Timer;
                    if (me->IsNonMeleeSpellCasted(false))
                        me->InterruptNonMeleeSpells(false);
                    if (doCast(target, COUNTERSPELL))
                    {
                        CounterSpell_cd = 15000;
                        GC_Timer = temptimer;
                    }
                }
            }
        }

        void CheckSpellSteal(uint32 diff)
        {
            if (!SPELLSTEAL || GC_Timer > diff || Rand() > 25 || IsCasting()) return;
            Unit* target = FindHostileDispelTarget(30, true);
            if (target && doCast(target, SPELLSTEAL))
                GC_Timer = 800;
        }

        void DoNonCombatActions(uint32 diff)
        {
            if (GC_Timer > diff || me->IsMounted()) return;
            if (Feasting()) return;

            if (DAMPENMAGIC && !HasAuraName(me, DAMPENMAGIC) &&
                doCast(me, DAMPENMAGIC))
            { /*GC_Timer = 800;*/ return; }

            if (ICEARMOR && !HasAuraName(me, ICEARMOR) &&
                doCast(me, ICEARMOR))
                return;
        }

        bool BuffTarget(Unit* target, uint32 diff)
        {
            if (GC_Timer > diff || Rand() > 20) return false;
            if (me->IsInCombat() && !master->GetMap()->IsRaid()) return false;
            if (me->GetExactDist(target) > 30) return false;
            if (ARCANEINTELLECT && target->getPowerType() == POWER_MANA && !HasAuraName(target, ARCANEINTELLECT) &&
                doCast(target, ARCANEINTELLECT))
                return true;

            return false;
        }

        void UpdateAI(uint32 diff)
        {
            ReduceCD(diff);
            if (95020 && GC_Timer <= diff && !me->HasAura(95020) && 
                doCast(me, 95020))
                GC_Timer = 1;
                
            if (95022 && GC_Timer <= diff && !me->HasAura(95022) && 
                doCast(me, 95022))
                GC_Timer = 1;
                
            if (IAmDead()) return;
            if (!me->GetVictim())
                Evade();
            if (clearcast && me->HasAura(CLEARCASTBUFF) && !me->IsNonMeleeSpellCasted(false))
            {
                me->ModifyPower(POWER_MANA, cost);
                me->RemoveAurasDueToSpell(CLEARCASTBUFF,me->GetGUID(),0,AURA_REMOVE_BY_EXPIRE);
                if (me->HasAura(ARCANE_POTENCY_BUFF1))
                    me->RemoveAurasDueToSpell(ARCANE_POTENCY_BUFF1,me->GetGUID(),0,AURA_REMOVE_BY_EXPIRE);
                if (me->HasAura(ARCANE_POTENCY_BUFF2))
                    me->RemoveAurasDueToSpell(ARCANE_POTENCY_BUFF2,me->GetGUID(),0,AURA_REMOVE_BY_EXPIRE);
                clearcast = false;
            }
            CheckAuras();
            if (wait == 0)
                wait = GetWait();
            else
                return;
            BreakCC(diff);
            if (CCed(me) && (!ICEBLOCK || !me->HasAura(ICEBLOCK))) return;//TODO

            CheckBlink(diff);
            CheckPoly(diff);
            CheckPots(diff);
            //CureTarget(master, REMOVE_CURSE, diff);
            //CureTarget(me, REMOVE_CURSE, diff);
            CureGroup(master, REMOVE_CURSE, diff);

            FocusMagic(diff);
            BuffAndHealGroup(master, diff);

            if (!me->IsInCombat())
                DoNonCombatActions(diff);

            if (!CheckAttackTarget(CLASS_MAGE))
                return;

            CheckPoly2();//this should go AFTER getting opponent

            Counter();
            CheckSpellSteal(diff);
            DoNormalAttack(diff);
        }

        void DoNormalAttack(uint32 diff)
        {
            opponent = me->GetVictim();
            if (opponent)
            {
                if (!IsCasting())
                    StartAttack(opponent);
            }
            else
                return;

            AttackerSet m_attackers = master->getAttackers();
            AttackerSet b_attackers = me->getAttackers();

            Unit* u = me->SelectNearestTarget(20);
            //ICE_BARRIER
            if (ICE_BARRIER && Ice_Barrier_cd <= diff && u && u->GetVictim() == me &&
                u->GetDistance(me) < 8 && !me->HasAura(ICE_BARRIER))
            {
                if (me->IsNonMeleeSpellCasted(true))
                    me->InterruptNonMeleeSpells(true);
                if (doCast(me, ICE_BARRIER))
                {
                    Ice_Barrier_cd = 25000;
                    GC_Timer = 800;
                    return;
                }
            }
            if ((!ICE_BARRIER || Ice_Barrier_cd > diff) &&
                BLINK && Blink_cd < 3000 && u && u->GetVictim() == me &&
                u->GetDistance(me) < 6 && !me->HasAura(ICE_BARRIER))
            {
                if (me->IsNonMeleeSpellCasted(true))
                    me->InterruptNonMeleeSpells(true);
                if (doCast(me, BLINK))
                {
                    Blink_cd = 13000;
                    GC_Timer = 800;
                    return;
                }
            }

            if (me->HasAura(ICEBLOCK))
                if (((GetManaPCT(me) > 45 && GetHealthPCT(me) > 80) || b_attackers.empty()) && Iceblock_cd <= 57000 && tank)
                    me->RemoveAurasDueToSpell(ICEBLOCK);
            //ICEBLOCK
            if (ICEBLOCK && Rand() < 50 && !b_attackers.empty() && tank && Iceblock_cd <= diff &&
                (GetManaPCT(me) < 15 || GetHealthPCT(me) < 45 || b_attackers.size() > 4) &&
                !me->HasAura(ICEBLOCK))
            {
                if (me->IsNonMeleeSpellCasted(true))
                    me->InterruptNonMeleeSpells(true);
                if (doCast(me, ICEBLOCK))
                {
                    Iceblock_cd = 60000;
                    Nova_cd = 0; //Glyph of Iceblock
                    return;
                }
            }

            if (IsCasting()) return;

            float dist = me->GetExactDist(opponent);
            if (dist > 30)
                return;

            BOLT = (CCed(opponent, true) || !FROSTBOLT) ? FIREBALL : FROSTBOLT;
            NOVA = BOLT == FROSTBOLT && BLASTWAVE && dist > 5 ? BLASTWAVE : FROSTNOVA ? FROSTNOVA : 0;

            if (COMBUSTION && Rand() < 15 && 
                (opponent->GetMaxHealth() > master->GetMaxHealth()*10 || 
                m_attackers.size() > 1 || b_attackers.size() > 2))
            {
                if (!HasAuraName(me, "Combustion") && Combustion_cd <= diff)
                {
                    temptimer = GC_Timer;
                    if (doCast(me, COMBUSTION))
                    {
                        Combustion_cd = 60000;
                        //Reset timers for fun
                        Nova_cd = 0; FireBlast_cd = 0; DragonBreath_cd = 0;
                    }
                    GC_Timer = temptimer;
                }
            }
            //DAMAGE
            //PYROBLAST
            if (PYROBLAST && Pyroblast_cd <= diff && GC_Timer <= diff && Rand() < 95 &&
                (b_attackers.size() < 2 || (*b_attackers.begin()) == opponent) &&
                dist < 40 && opponent->IsPolymorphed() &&
                doCast(opponent, PYROBLAST))
            {
                Pyroblast_cd = 7500;
                //debug
                DragonBreath_cd = std::max<uint32>(DragonBreath_cd, 450);
                Nova_cd = std::max<uint32>(Nova_cd, 450);
                return;
            }
            //nova //TODO: SEPARATE
            u = me->SelectNearestTarget(6.3f);
            if (NOVA && Nova_cd <= diff && u && Rand() < 75 && !CCed(u, true) && IsInBotParty(u->GetVictim()))
            {
                if (doCast(me, NOVA))
                {
                    Nova_cd = 15000;
                    GetInPosition(true);
                    return;
                }
            }
            //living bomb
            if (LIVINGBOMB && Living_Bomb_cd <= diff && GC_Timer <= diff && Rand() < 45 && dist < 40 &&
                opponent->GetHealth() > me->GetHealth()/2 &&
                !opponent->HasAura(LIVINGBOMB, me->GetGUID()) &&
                doCast(opponent, LIVINGBOMB))
            {
                Living_Bomb_cd = 6000;
                GC_Timer = 500;
                return;
            }
            //cone of cold
            if (CONEOFCOLD && ConeofCold_cd <= diff && GC_Timer <= diff && Rand() < 50 && dist < 7 &&
                me->HasInArc(M_PI*0.75f, opponent) &&
                doCast(opponent, CONEOFCOLD))
            {
                ConeofCold_cd = 8000;
                GC_Timer = 500;
                GetInPosition(true);
                return;
            }
            //dragon's breath
            if (DRAGONBREATH && DragonBreath_cd <= diff && GC_Timer <= diff && !CCed(opponent, true) &&
                ((me->HasInArc(M_PI*0.75f, opponent) && dist < 7) ||
                (u && u != opponent && me->HasInArc(M_PI*0.75f, u) && IsInBotParty(u->GetVictim()))) &&
                doCast(/*opponent*/me, DRAGONBREATH))
            {
                DragonBreath_cd = 25000;
                GC_Timer = 800;
                return;
            }
            /*//blast wave //TODO Separate again
            u = me->SelectNearestTarget(8);
            if (BLASTWAVE != 0 && u && isTimerReady(BlastWave_cd) &&
                !HasAuraName(u, FROSTNOVA) && !HasAuraName(u, DRAGONBREATH) &&
                doCast(me, BLASTWAVE))
            {
                BlastWave_cd = BLASTWAVE_CD;
                GC_Timer = 800;
            }*/
            //fire blast
            if (FIREBLAST && FireBlast_cd <= diff && GC_Timer <= diff && dist < 30)
            {
                if (Rand() < 20 + 80*(!opponent->isFrozen() && !opponent->HasAuraType(SPELL_AURA_MOD_STUN) && me->HasAura(IMPACT_BUFF)))
                {
                    if (doCast(opponent, FIREBLAST))
                    {

                        FireBlast_cd = 6000;
                        GC_Timer = 500;
                        return;
                    }
                }
            }
            //flamestrike - use Improved Flamestrike for instant cast
            if (FLAMESTRIKE && GC_Timer <= diff && me->HasAura(FIRESTARTERBUFF) && Rand() < 25)
            {
                Unit* FStarget = FindAOETarget(30, true, false);
                if (FStarget && doCast(FStarget, FLAMESTRIKE, true))
                {
                    me->RemoveAurasDueToSpell(FIRESTARTERBUFF);
                    GC_Timer = 0;
                    return;
                }
            }
            //blizzard
            if (BLIZZARD && Blizzard_cd <= diff && !me->isMoving() && Rand() < 40)
            {
                Unit* blizztarget = FindAOETarget(30, true);
                if (blizztarget && doCast(blizztarget, BLIZZARD))
                {
                    Blizzard_cd = 5000;
                    return;
                }
                Blizzard_cd = 1500; //fail
            }
            //Frost of Fire Bolt
            if (BOLT && Bolt_cd <= diff && Rand() < 75 && dist < 30 &&
                doCast(opponent, BOLT))
            {
                Bolt_cd = uint32(float(sSpellMgr->GetSpellInfo(BOLT)->CalcCastTime()/100) * me->GetFloatValue(UNIT_MOD_CAST_SPEED) + 200);
                //debug
                DragonBreath_cd = std::max<uint32>(DragonBreath_cd, 450);
                Nova_cd = std::max<uint32>(Nova_cd, 450);
                return;
            }
            //Arcane Missiles
            if (Rand() < 10 && GC_Timer <= diff && !me->isMoving() && dist < 20 && 
                doCast(opponent, ARCANEMISSILES))
                return;
        }

        void CheckPoly(uint32 diff)
        {
            if (polyCheckTimer <= diff && POLYMORPH)
            {
                Polymorph = FindAffectedTarget(POLYMORPH, me->GetGUID());
                polyCheckTimer = 2000;
            }
        }

        void CheckPoly2()
        {
            if (POLYMORPH && Polymorph == false && GC_Timer < 500)
            {
                if (Unit* target = FindPolyTarget(30, me->GetVictim()))
                {
                    if (doCast(target, POLYMORPH))
                    {
                        Polymorph = true;
                        polyCheckTimer += 2000;
                    }
                }
            }
        }

        void CheckPots(uint32 diff)
        {
            if (me->IsMounted() || IsCasting()) return;

            if (GetHealthPCT(me) < 67 && Potion_cd <= diff)
            {
                temptimer = GC_Timer;
                if (doCast(me, HEALINGPOTION))
                {
                    Potion_cd = POTION_CD;
                    GC_Timer = temptimer;
                }
            }
            if (GetManaPCT(me) < 35 && Rand() < 35)
            {
                if (EVOCATION && Evocation_cd <= diff && !me->isMoving() &&
                    me->getAttackers().empty() && doCast(me, EVOCATION))
                    Evocation_cd = 60000;
                else if (Potion_cd <= diff)
                {
                    temptimer = GC_Timer;
                    if (doCast(me, MANAPOTION))
                    {
                        Potion_cd = POTION_CD;
                        GC_Timer = temptimer;
                    }
                }
            }
        }

        void CheckBlink(uint32 diff)
        {
            if (GetBotCommandState() == COMMAND_STAY || me->IsMounted()) return;
            if (!BLINK || Blink_cd > diff || me->getLevel() < 20 || IsCasting()) return;
            if (!me->IsInCombat() && me->GetExactDist(master) > std::max(float(master->GetBotFollowDist()), 35.f) &&
                me->HasInArc(M_PI*0.75f, master))
            {
                temptimer = GC_Timer;
                if (doCast(me, BLINK))
                {
                    Blink_cd = 13000;
                    GC_Timer = temptimer;
                }
                return;
            }
            if (!me->getAttackers().empty() && me->GetExactDist(master) > 15)
            {
                if (Unit* op = me->SelectNearestTarget(7))
                {
                    if (op->GetVictim() == me)
                    {
                        me->SetFacingTo(me->GetAngle(master));
                        temptimer = GC_Timer;
                        if (doCast(me, BLINK))
                        {
                            Blink_cd = 13000;
                            GC_Timer = temptimer;
                        }
                    }
                }
            }
        }

        void FocusMagic(uint32 diff)
        {
            if (!FOCUSMAGIC || fmCheckTimer > diff || GC_Timer > diff ||
                me->getLevel() < 20 || Rand() < 50 || IsCasting())
                return;

            if (Unit* target = FindAffectedTarget(FOCUSMAGIC, me->GetGUID(), 70, 2))
            {
                fmCheckTimer = 15000;
                return;
            }
            else
            {
                Group* pGroup = master->GetGroup();
                if (!pGroup)
                {
                    if (master->getPowerType() == POWER_MANA && me->GetExactDist(master) < 30 &&
                        !master->HasAura(FOCUSMAGIC))
                    target = master;
                }
                else
                {
                    for (GroupReference* itr = pGroup->GetFirstMember(); itr != NULL; itr = itr->next())
                    {
                        Player* pPlayer = itr->GetSource();
                        if (!pPlayer || pPlayer->IsInWorld() || pPlayer->isDead()) continue;
                        if (me->GetMapId() != pPlayer->GetMapId()) continue;
                        if (pPlayer->getPowerType() == POWER_MANA && me->GetExactDist(pPlayer) < 30 &&
                            !pPlayer->HasAura(FOCUSMAGIC))
                        {
                            target = pPlayer;
                            break;
                        }
                    }
                    if (!target)
                    {
                        for (GroupReference* itr = pGroup->GetFirstMember(); itr != NULL; itr = itr->next())
                        {
                            Player* pPlayer = itr->GetSource();
                            if (!pPlayer || !pPlayer->IsInWorld() || !pPlayer->HaveBot()) continue;
                            if (me->GetMapId() != pPlayer->GetMapId()) continue;
                            for (uint8 i = 0; i != pPlayer->GetMaxNpcBots(); ++i)
                            {
                                Creature* cre = pPlayer->GetBotMap(i)->_Cre();
                                if (!cre || !cre->IsInWorld() || cre == me || cre->isDead()) continue;
                                if (cre->getPowerType() == POWER_MANA && me->GetExactDist(cre) < 30 &&
                                    !cre->HasAura(FOCUSMAGIC))
                                {
                                    target = cre;
                                    break;
                                }
                            }
                        }
                    }
                }

                if (target && doCast(target, FOCUSMAGIC))
                {
                    GC_Timer = 500;
                    fmCheckTimer = 30000;
                    return;
                }
            }

            fmCheckTimer = 5000;
        }

        void ApplyClassDamageMultiplierSpell(int32& damage, SpellNonMeleeDamage& /*damageinfo*/, SpellInfo const* spellInfo, WeaponAttackType /*attackType*/, bool& crit) const
        {
            uint32 spellId = spellInfo->Id;
            uint8 lvl = me->getLevel();
            float fdamage = float(damage);
            //1) apply additional crit chance. This additional chance roll will replace original (balance safe)
            if (!crit)
            {
                float aftercrit = 0.f;
                //Combustion: 10% per stack
                if (SPELL_SCHOOL_MASK_FIRE & spellInfo->GetSchoolMask())
                    if (Aura* combustion = me->GetAura(COMBUSTION_BUFF))
                        aftercrit += float(combustion->GetStackAmount()*10);
                //Incineration: 6% additional critical chance for Fire Blast, Scorch, Arcane Blast and Cone of Cold
                if (lvl >= 10 &&
                    (spellId == FIREBLAST ||
                    spellId == CONEOFCOLD/* ||
                    spellId == ARCANEBLAST ||
                    spellId == SCORCH*/))
                    aftercrit += 6.f;
                //World In Flames: 6% additional critical chance for
                //Flamestrike, Pyroblast, Blast Wave, Dragon's Breath, Living Bomb, Blizzard and Arcane Explosion
                if (lvl >= 15 &&
                    (spellId == FLAMESTRIKE ||
                    spellId == PYROBLAST ||
                    spellId == BLASTWAVE ||
                    spellId == DRAGONBREATH/* ||
                    spellId == ARCANEXPLOSION ||
                    spellId == LIVINGBOMB ||    //cannot be handled here
                    spellId == BLIZZARD*/))    //cannot be handled here
                    aftercrit += 6.f;

                if (aftercrit > 0.f)
                    crit = roll_chance_f(aftercrit);
            }

            //2) apply bonus damage mods
            float pctbonus = 0.0f;
            if (crit)
            {
                //!!!spell damage is not yet critical and will be multiplied by 1.5
                //so we should put here bonus damage mult /1.5
                //Spell Power: 50% additional crit damage bonus for All spells
                if (lvl >= 55)
                    pctbonus += 0.333f;
                //Ice Shards: 50% additional crit damage bonus for Frost spells
                else if (lvl >= 15 && (SPELL_SCHOOL_MASK_FROST & spellInfo->GetSchoolMask()))
                    pctbonus += 0.333f;
            }
            //Improved Cone of Cold: 35% bonus damage for Cone of Cold
            if (lvl >= 30 && spellId == CONEOFCOLD)
                pctbonus += 0.35f;
            //Fire Power: 10% bonus damage for Fire spells
            if (lvl >= 35 && (SPELL_SCHOOL_MASK_FIRE & spellInfo->GetSchoolMask()))
                pctbonus += 0.1f;

            damage = int32(fdamage * (1.0f + pctbonus));
        }

        void SpellHit(Unit* caster, SpellInfo const* spell)
        {
            OnSpellHit(caster, spell);
        }

        void SpellHitTarget(Unit* /*target*/, SpellInfo const* spell)
        {
            if (aftercastTargetGuid != 0)
            {
                //only players for now
                if (!IS_PLAYER_GUID(aftercastTargetGuid))
                {
                    aftercastTargetGuid = 0;
                    return;
                }
                Player* pTarget = sObjectAccessor->FindPlayer(aftercastTargetGuid);
                aftercastTargetGuid = 0;
                if (!pTarget/* || me->GetDistance(pTarget) > 15*/)
                    return;

                //handle effects
                for (uint8 i = 0; i != MAX_SPELL_EFFECTS; ++i)
                {
                    switch (spell->Effects[i].Effect)
                    {
                        case SPELL_EFFECT_CREATE_ITEM:
                        case SPELL_EFFECT_CREATE_ITEM_2:
                        {
                            uint32 newitemid = spell->Effects[i].ItemType;
                            if (newitemid)
                            {
                                ItemPosCountVec dest;
                                ItemTemplate const* pProto = sObjectMgr->GetItemTemplate(newitemid);
                                if (!pProto)
                                    return;
                                uint32 count = pProto->GetMaxStackSize();
                                uint32 no_space = 0;
                                InventoryResult msg = pTarget->CanStoreNewItem(NULL_BAG, NULL_SLOT, dest, newitemid, count, &no_space);
                                if (msg != EQUIP_ERR_OK)
                                {
                                    if (msg == EQUIP_ERR_INVENTORY_FULL || msg == EQUIP_ERR_CANT_CARRY_MORE_OF_THIS)
                                        count -= no_space;
                                    else
                                    {
                                        // if not created by another reason from full inventory or unique items amount limitation
                                        pTarget->SendEquipError(msg, NULL, NULL, newitemid);
                                        continue;
                                    }
                                }
                                if (count)
                                {
                                    Item* pItem = pTarget->StoreNewItem(dest, newitemid, true, Item::GenerateItemRandomPropertyId(newitemid));
                                    if (!pItem)
                                    {
                                        pTarget->SendEquipError(EQUIP_ERR_ITEM_NOT_FOUND, NULL, NULL);
                                        continue;
                                    }
                                    //unsafe possible
                                    pItem->SetUInt32Value(ITEM_FIELD_CREATOR, me->GetGUIDLow());

                                    pTarget->SendNewItem(pItem, count, true, false, true);
                                }
                            }
                            break;
                        }
                        default:
                            break;
                    }
                }
            }
        }

        void DamageDealt(Unit* victim, uint32& /*damage*/, DamageEffectType damageType)
        {
            if (victim == me)
                return;

            if (damageType == DIRECT_DAMAGE || damageType == SPELL_DIRECT_DAMAGE)
            {
                for (uint8 i = 0; i != MAX_BOT_CTC_SPELLS; ++i)
                {
                    if (_ctc[i].first && !_ctc[i].second)
                    {
                        if (urand(1,100) <= CalcCTC(_ctc[i].first))
                            _ctc[i].second = 1000;

                        if (_ctc[i].second > 0)
                            me->CastSpell(victim, _ctc[i].first, true);
                    }
                }
            }
        }

        void DamageTaken(Unit* u, uint32& /*damage*/)
        {
            OnOwnerDamagedBy(u);
        }

        void OwnerAttackedBy(Unit* u)
        {
            OnOwnerDamagedBy(u);
        }

        void Reset()
        {
            Pyroblast_cd = 0;
            FireBlast_cd = 0;
            DragonBreath_cd = 0;
            Living_Bomb_cd = 0;
            Combustion_cd = 30000;//30 sec for reset
            Ice_Barrier_cd = 0;
            Iceblock_cd = 0;
            ConeofCold_cd = 0;
            Blizzard_cd = 10000;
            CounterSpell_cd = 0;
            Evocation_cd = 0;
            Blink_cd = 0;
            Bolt_cd = 0;
            Nova_cd = 0;
            polyCheckTimer = 0;
            fmCheckTimer = 0;
            Polymorph = false;
            clearcast = false;
            BOLT = 0;
            NOVA = 0;

            if (master)
            {
                setStats(CLASS_MAGE, me->getRace(), master->getLevel(), true);
                ApplyClassPassives();
                ApplyPassives(CLASS_MAGE);
           }
        }

        void ReduceCD(uint32 diff)
        {
            CommonTimers(diff);
            if (Pyroblast_cd > diff)            Pyroblast_cd -= diff;
            if (Ice_Barrier_cd > diff)          Ice_Barrier_cd -= diff;
            if (Iceblock_cd > diff)             Iceblock_cd -= diff;
            if (ConeofCold_cd > diff)           ConeofCold_cd -= diff;
            if (Living_Bomb_cd > diff)          Living_Bomb_cd -= diff;
            if (FireBlast_cd > diff)            FireBlast_cd -= diff;
            if (Bolt_cd > diff)                 Bolt_cd -= diff;
            if (Blizzard_cd > diff)             Blizzard_cd -= diff;
            if (CounterSpell_cd > diff)         CounterSpell_cd -= diff;
            if (Nova_cd > diff)                 Nova_cd -= diff;
            if (DragonBreath_cd > diff)         DragonBreath_cd -= diff;
            if (Blink_cd > diff)                Blink_cd -= diff;
            if (Combustion_cd > diff)           Combustion_cd -= diff;
            if (Evocation_cd > diff)            Evocation_cd -= diff;
            if (polyCheckTimer > diff)          polyCheckTimer -= diff;
            if (fmCheckTimer > diff)            fmCheckTimer -= diff;
        }

        bool CanRespawn()
        {return false;}

        void InitSpells()
        {
            uint8 lvl = me->getLevel();
            DAMPENMAGIC                             = InitSpell(me, DAMPENMAGIC_1);
            ARCANEINTELLECT                         = InitSpell(me, ARCANEINTELLECT_1);
            ARCANEMISSILES                          = InitSpell(me, ARCANEMISSILES_1);
            POLYMORPH                               = InitSpell(me, POLYMORPH_1);
            COUNTERSPELL                            = InitSpell(me, COUNTERSPELL_1);
            SPELLSTEAL                              = InitSpell(me, SPELLSTEAL_1);
            EVOCATION                               = InitSpell(me, EVOCATION_1);
            BLINK                                   = InitSpell(me, BLINK_1);
            REMOVE_CURSE                            = InitSpell(me, REMOVE_CURSE_1);
            //INVISIBILITY                            = InitSpell(me, INVISIBILITY_1);
            FIREBALL                                = InitSpell(me, FIREBALL_1);
            BLASTWAVE                   = lvl >= 30 ? InitSpell(me, BLASTWAVE_1) : 0;
            DRAGONBREATH                = lvl >= 40 ? InitSpell(me, DRAGONBREATH_1) : 0;
            FIREBLAST                               = InitSpell(me, FIREBLAST_1);
            PYROBLAST                   = lvl >= 20 ? InitSpell(me, PYROBLAST_1) : 0;
            LIVINGBOMB                  = lvl >= 60 ? InitSpell(me, LIVINGBOMB_1) : 0;
            FLAMESTRIKE                             = InitSpell(me, DAMPENMAGIC_1);
            COMBUSTION                  = lvl >= 50 ? COMBUSTION_1 : 0;
            FROSTBOLT                               = InitSpell(me, FROSTBOLT_1);
            FROSTNOVA                               = InitSpell(me, FROSTNOVA_1);
            CONEOFCOLD                              = InitSpell(me, CONEOFCOLD_1);
            BLIZZARD                                = InitSpell(me, BLIZZARD_1);
            ICEARMOR                    = lvl >= 20 ? InitSpell(me, ICEARMOR_1) : InitSpell(me, FROSTARMOR_1);
            ICE_BARRIER                 = lvl >= 40 ? InitSpell(me, ICE_BARRIER_1) : 0;
            ICEBLOCK                                = InitSpell(me, ICEBLOCK_1);
            FOCUSMAGIC                  = lvl >= 20 ? FOCUSMAGIC_1 : 0;
        }

        void ApplyClassPassives()
        {
            uint8 level = master->getLevel();
            //Dam+(-Hit)
            if (level >= 50)
                RefreshAura(ARCTIC_WINDS,3); //+15%/-15%
            else if (level >= 25)
                RefreshAura(ARCTIC_WINDS,2); //+10%/-10%
            else if (level >= 10)
                RefreshAura(ARCTIC_WINDS); //+5%/-5%
            //CHILL
            if (level >= 30)
                RefreshAura(WINTERS_CHILL3); //100%
            else if (level >= 25)
                RefreshAura(WINTERS_CHILL2); //66%
            else if (level >= 20)
                RefreshAura(WINTERS_CHILL1); //33%
            //Imp Blizzard
            if (level >= 20)
                RefreshAura(IMPROVED_BLIZZARD); //50% slow
            //Frostbite
            if (level >= 80)
                FROSTBITE = FROSTBITE3;
            else if (level >= 50)
                FROSTBITE = FROSTBITE2;
            else if (level >= 10)
                FROSTBITE = FROSTBITE1;
            if (level >= 60)
                RefreshAura(FROSTBITE,3);//3x
            else if (level >= 30)
                RefreshAura(FROSTBITE,2);//2x
            else if (level >= 10)
                RefreshAura(FROSTBITE);//1x
            //Shattered Barrier
            if (level >= 45)
                RefreshAura(SHATTERED_BARRIER);
            //Bonus
            if (level >= 65)
                RefreshAura(ARCANE_INSTABILITY,4); //+12%dmg crit
            else if (level >= 55)
                RefreshAura(ARCANE_INSTABILITY,3); //+9%dmg crit
            else if (level >= 45)
                RefreshAura(ARCANE_INSTABILITY,2); //+6%dmg crit
            else if (level >= 35)
                RefreshAura(ARCANE_INSTABILITY); //+3%dmg crit
            //Absorb
            if (level >= 50)
                RefreshAura(INCANTERS_ABSORPTION3);
            else if (level >= 45)
                RefreshAura(INCANTERS_ABSORPTION2);
            else if (level >= 40)
                RefreshAura(INCANTERS_ABSORPTION1);
            //Shatter
            if (level >= 35)
                RefreshAura(SHATTER3);
            else if (level >= 30)
                RefreshAura(SHATTER2);
            else if (level >= 25)
                RefreshAura(SHATTER1);
            //ClearCasting
            if (level >= 75)
                RefreshAura(CLEARCAST,3); //30%
            else if (level >= 40)
                RefreshAura(CLEARCAST,2); //20%
            else if (level >= 15)
                RefreshAura(CLEARCAST); //10%
            //Fingers
            if (level >= 45)
                RefreshAura(FINGERS_OF_FROST); //15%
            //Potency
            if (level >= 40)
                RefreshAura(ARCANE_POTENCY2); //30% bonus
            else if (level >= 35)
                RefreshAura(ARCANE_POTENCY1); //15% bonus
            //Ignite
            if (level >= 15)
                RefreshAura(IGNITE);
            //Impact
            if (level >= 60)
                RefreshAura(IMPACT,2);
            else if (level >= 20)
                RefreshAura(IMPACT);
            //Imp. Counterspell
            if (level >= 35)
                RefreshAura(IMPROVED_COUNTERSPELL2); //4 sec
            else if (level >= 25)
                RefreshAura(IMPROVED_COUNTERSPELL1); //2 sec
            //Firestarter
            if (level >= 55)
                RefreshAura(FIRESTARTER2);//100% chance
            else if (level >= 45)
                RefreshAura(FIRESTARTER1);//50% chance
            //Spells
            if (LIVINGBOMB)
                RefreshAura(GLYPH_LIVING_BOMB);
            if (POLYMORPH)
                RefreshAura(GLYPH_POLYMORPH);

        }

    private:
        uint32
  /*Arcane*/DAMPENMAGIC, ARCANEINTELLECT, ARCANEMISSILES, POLYMORPH, COUNTERSPELL, FOCUSMAGIC,
  /*Arcane*/SPELLSTEAL, EVOCATION, BLINK, REMOVE_CURSE, /*INVISIBILITY,*/
    /*Fire*/FIREBALL, FIREBLAST, FLAMESTRIKE, PYROBLAST, COMBUSTION, BLASTWAVE, DRAGONBREATH, LIVINGBOMB,
   /*Frost*/FROSTBOLT, FROSTNOVA, CONEOFCOLD, BLIZZARD, ICEARMOR, ICEBLOCK, ICE_BARRIER, FROSTBITE;
        //Timers
/*fire*/uint32 Pyroblast_cd, FireBlast_cd, DragonBreath_cd, Living_Bomb_cd, Combustion_cd;
/*frst*/uint32 Ice_Barrier_cd, ConeofCold_cd, Blizzard_cd, Iceblock_cd;
/*arcn*/uint32 CounterSpell_cd, Blink_cd, Evocation_cd;
/*exc.*/uint32 Bolt_cd, Nova_cd;
/*exc.*/uint32 BOLT, NOVA;
/*exc.*/uint32 polyCheckTimer, fmCheckTimer;
        //Check
/*exc.*/bool Polymorph, clearcast;

        enum MageBaseSpells// all orignals
        {
            DAMPENMAGIC_1                       = 604,
            ARCANEINTELLECT_1                   = 1459,
            ARCANEMISSILES_1                    = 5143,
            POLYMORPH_1                         = 118,
            COUNTERSPELL_1                      = 2139,
            SPELLSTEAL_1                        = 30449,
            EVOCATION_1                         = 12051,
            BLINK_1                             = 1953,
            REMOVE_CURSE_1                      = 475,
            //INVISIBILITY_1                      = 0,
            FIREBALL_1                          = 133,
            BLASTWAVE_1                         = 11113,
            DRAGONBREATH_1                      = 31661,
            FIREBLAST_1                         = 2136,
            PYROBLAST_1                         = 11366,
            LIVINGBOMB_1                        = 44457,
            FLAMESTRIKE_1                       = 2120,
            COMBUSTION_1                        = 11129,
            FROSTBOLT_1                         = 116,
            FROSTNOVA_1                         = 122,
            CONEOFCOLD_1                        = 120,
            BLIZZARD_1                          = 10,
            FROSTARMOR_1                        = 168,
            ICEARMOR_1                          = 7302,
            ICE_BARRIER_1                       = 11426,
            ICEBLOCK_1                          = 45438,
            FOCUSMAGIC_1                        = 54646
        };

        enum MagePassives
        {
        //Talents
            SHATTERED_BARRIER                   = 54787,//rank 2
            ARCTIC_WINDS                        = 31678,//rank 5
            WINTERS_CHILL1                      = 11180,
            WINTERS_CHILL2                      = 28592,
            WINTERS_CHILL3                      = 28593,
            FROSTBITE1                          = 11071,
            FROSTBITE2                          = 12496,
            FROSTBITE3                          = 12497,
            IMPROVED_BLIZZARD                   = 12488,//rank 3
            CLEARCAST /*Arcane Concentration*/  = 12577,//rank 5
            ARCANE_POTENCY1                     = 31571,
            ARCANE_POTENCY2                     = 31572,
            SHATTER1                            = 11170,
            SHATTER2                            = 12982,
            SHATTER3                            = 12983,
            INCANTERS_ABSORPTION1               = 44394,
            INCANTERS_ABSORPTION2               = 44395,
            INCANTERS_ABSORPTION3               = 44396,
            FINGERS_OF_FROST                    = 44545,//rank 2
            ARCANE_INSTABILITY                  = 15060,//rank 3
            IMPROVED_COUNTERSPELL1              = 11255,
            IMPROVED_COUNTERSPELL2              = 12598,
            IGNITE                              = 12848,
            FIRESTARTER1                        = 44442,
            FIRESTARTER2                        = 44443,
            IMPACT                              = 12358,
            GLYPH_LIVING_BOMB                   = 63091,
        //Special
            GLYPH_POLYMORPH                     = 56375
        };
        enum MageSpecial
        {
            CLEARCASTBUFF                       = 12536,
            IMPACT_BUFF                         = 64343,
            FIRESTARTERBUFF                     = 54741,
            ARCANE_POTENCY_BUFF1                = 57529,
            ARCANE_POTENCY_BUFF2                = 57531,
            COMBUSTION_BUFF                     = 28682
        };
    };
};

void AddSC_mage_bot()
{
    new mage_bot();
}
