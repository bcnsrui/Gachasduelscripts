--Gacha's Duel is Kami Game
Gacha3={}

function Gacha3.DuelAtkUnitCharacter(c)
	Gacha3.DuelAtkUnitCharacter1(c)
	Gacha3.DuelAtkUnitCharacter2(c)
end

--협동공격
function Gacha3.DuelAtkUnitCharacter1(c)
    local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(11040005,0))
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_BATTLE_START)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCondition(Gacha3.battlecon)
	e1:SetOperation(Gacha3.battleop)
    c:RegisterEffect(e1)
end
function Gacha3.battlecon(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:IsControler(tp) and not (at:IsCode(11040005) and at:IsSetCard(0xa02))
	and not at:IsSetCard(0xa12)
end
function Gacha3.battlefilter(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and not c:IsLocation(LOCATION_EMZONE+LOCATION_FZONE) and not c:IsSetCard(0xa01)
end
function Gacha3.battleop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DEFENSE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL)
		c:RegisterEffect(e1)
	Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
	if c:IsSetCard(0xa01) then return end
	if Duel.IsExistingMatchingCard(Gacha3.battlefilter,tp,LOCATION_ONFIELD,0,1,nil)
	and Duel.SelectYesNo(tp,aux.Stringid(11020001,0)) then
	local g=Duel.SelectMatchingCard(tp,Gacha3.battlefilter,tp,LOCATION_ONFIELD,0,0,1,nil)
	local tc=g:GetFirst()
	if #g==0 then return end
	Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EFFECT_ADD_SETCODE)
		e2:SetRange(LOCATION_ONFIELD)
		e2:SetValue(0xa04)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		c:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetCode(EFFECT_ADD_SETCODE)
		e3:SetRange(LOCATION_ONFIELD)
		e3:SetValue(0xa04)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e3)
		local def=tc:GetDefense()
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_UPDATE_DEFENSE)
		e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e4:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL)
		e4:SetValue(def)
		c:RegisterEffect(e4)
		if tc:IsCode(11060001) then
		Gacha3.UrsaUnit(e,tp,eg,ep,ev,re,r,rp)	end
		if tc:IsCode(11060006) and tc:IsSetCard(0xb04) then
		Gacha3.RoseUnit(e,tp,eg,ep,ev,re,r,rp)	end
	end
end

--작은곰자리
function Gacha3.UrsaUnit(e,tp,eg,ep,ev,re,r,rp)
	local ag=Duel.GetMatchingGroup(Gacha3.Ursafilter2,tp,0,LOCATION_ONFIELD,nil)
	local em=Duel.GetMatchingGroup(nil,tp,0,LOCATION_EMZONE,nil)
	local em2=Duel.GetMatchingGroup(Gacha3.Ursafilter3,tp,0,LOCATION_ONFIELD,nil)
	if #ag==0 then return end
	local c=e:GetHandler()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_FIELD)
		e1:SetCode(EFFECT_ADD_SETCODE)
		e1:SetRange(LOCATION_ONFIELD)
		e1:SetTargetRange(0,LOCATION_ONFIELD)
		e1:SetTarget(aux.TargetBoolFunction(Card.IsLevelBelow,4))
		e1:SetValue(0xb03)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL)
		c:RegisterEffect(e1)
	ag:ForEach(function(tc)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_CANNOT_TRIGGER)
		e2:SetRange(LOCATION_ONFIELD)
		e2:SetTargetRange(LOCATION_ONFIELD,0)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL)
		tc:RegisterEffect(e2)
	end)
	if #em2<2 then
	em:ForEach(function(tc2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_CANNOT_TRIGGER)
		e3:SetRange(LOCATION_ONFIELD)
		e3:SetTargetRange(LOCATION_ONFIELD,0)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL)
		tc2:RegisterEffect(e3)
	end) end
end
function Gacha3.Ursafilter2(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsLevelBelow(4) and not c:IsLocation(LOCATION_EMZONE+LOCATION_FZONE)
end
function Gacha3.Ursafilter3(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and c:IsLevelAbove(5) and not c:IsLocation(LOCATION_EMZONE+LOCATION_FZONE)
end

--로즈 브라이드
function Gacha3.RoseUnit(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e3:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e3:SetRange(LOCATION_ONFIELD)
	e3:SetCode(EVENT_DAMAGE)
	e3:SetCondition(Gacha3.rosedamcon)
	e3:SetOperation(Gacha3.rosedamop)
	c:RegisterEffect(e3)
end
function Gacha3.rosedamcon(e,tp,eg,ep,ev,re,r,rp)
	return ep~=tp
end
function Gacha3.rosefllter(c)
	return not c:IsLocation(LOCATION_EMZONE+LOCATION_FZONE)
end
function Gacha3.rosedamop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetMatchingGroupCount(Gacha3.rosefllter,tp,0,LOCATION_ONFIELD,nil)>=5 
	or Duel.GetMatchingGroupCount(Card.IsSetCard,tp,LOCATION_ONFIELD,0,nil,0xa10)>=1 then
	local ct=Duel.GetMatchingGroup(Card.IsFacedown,tp,0,LOCATION_EXTRA,nil)
	if #ct==0 then return Duel.Win(tp,WIN_REASON_GHOSTRICK_MISCHIEF) end
	local last=ct:GetFirst()
	local tc=ct:GetNext()
	for tc in aux.Next(ct) do
		if tc:GetSequence()<last:GetSequence() then last=tc end
	end
	Duel.SendtoGrave(last,REASON_RULE)
	Duel.SendtoExtraP(last,1-tp,REASON_RULE)
	local ct2=Duel.GetMatchingGroup(Card.IsFaceup,tp,0,LOCATION_EXTRA,nil)	
	if #ct2==7 then return Duel.Win(tp,WIN_REASON_GHOSTRICK_MISCHIEF) end end
end

--협동공격(1체공격불가)
function Gacha3.DuelAtkUnitCharacter2(c)
    local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_BATTLE_START)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCondition(Gacha3.battlecon2)
	e1:SetOperation(Gacha3.battleop2)
    c:RegisterEffect(e1)
end
function Gacha3.battlecon2(e,tp,eg,ep,ev,re,r,rp)
	local at=Duel.GetAttacker()
	return at:IsControler(tp) and at:IsSetCard(0xa12)
	and Duel.IsExistingMatchingCard(Gacha3.battlefilter2,tp,LOCATION_ONFIELD,0,1,e:GetHandler())
end
function Gacha3.battlefilter2(c)
	return c:IsPosition(POS_FACEUP_ATTACK) and not c:IsLocation(LOCATION_EMZONE+LOCATION_FZONE) and not c:IsSetCard(0xa01)
end
function Gacha3.battleop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DEFENSE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL)
		c:RegisterEffect(e1)
		local g=Duel.SelectMatchingCard(tp,Gacha3.battlefilter2,tp,LOCATION_ONFIELD,0,1,1,c)
		local tc=g:GetFirst()
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetCode(EFFECT_ADD_SETCODE)
		e2:SetRange(LOCATION_ONFIELD)
		e2:SetValue(0xa04)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		c:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetCode(EFFECT_ADD_SETCODE)
		e3:SetRange(LOCATION_ONFIELD)
		e3:SetValue(0xa04)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e3)
		local def=tc:GetDefense()
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetCode(EFFECT_UPDATE_DEFENSE)
		e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e4:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL)
		e4:SetValue(def)
		c:RegisterEffect(e4)
		if tc:IsCode(11060001) then
		Gacha3.UrsaUnit(e,tp,eg,ep,ev,re,r,rp)	end
		if tc:IsCode(11060006) and tc:IsSetCard(0xb04) then
		Gacha3.RoseUnit(e,tp,eg,ep,ev,re,r,rp)	end
end

--협동방어
function Gacha3.DuelDefMainCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_ATKCHANGE)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetRange(LOCATION_EMZONE)
	e1:SetCondition(Gacha3.btcountercon)
	e1:SetTarget(Gacha3.btcountertg)
	e1:SetOperation(Gacha3.btcounterop)
	c:RegisterEffect(e1)
end
function Gacha3.btcountercon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.GetAttacker():IsControler(1-tp) and Duel.GetAttackTarget()==nil
	and Duel.IsExistingMatchingCard(Gacha3.Ursafilter,tp,LOCATION_ONFIELD,0,2,c)
end
function Gacha3.btcountertg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return true end
	Duel.SetChainLimit(aux.FALSE)
end
function Gacha3.Ursafilter(c)
	return c:IsAttackPos() and not c:IsLocation(LOCATION_EMZONE+LOCATION_FZONE)
	and not c:IsSetCard(0xb03) and not c:IsSetCard(0xa11)
end
function Gacha3.btcounterop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local at=Duel.GetAttacker()
	local g=Duel.SelectMatchingCard(tp,Gacha3.Ursafilter,tp,LOCATION_ONFIELD,0,0,2,c)
	if #g<2 and at:CanAttack() then return end
	Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
		local tc1=g:GetFirst()
		local tc2=g:Sub(tc1):GetFirst()
		local def2=tc2:GetDefense()
		local e1=Effect.CreateEffect(tc1)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_DEFENSE)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(def2)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL)
		tc1:RegisterEffect(e1)
		local e2=Effect.CreateEffect(tc2)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_LEAVE_FIELD)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetRange(LOCATION_ONFIELD)
		e2:SetReset(RESET_PHASE+PHASE_DAMAGE)
		e2:SetCondition(Gacha3.btcounterdescon)
		e2:SetOperation(Gacha3.btcounterdesop)
		tc2:RegisterEffect(e2)
		local e3=Effect.CreateEffect(tc1)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
		e3:SetCode(EFFECT_ADD_SETCODE)
		e3:SetRange(LOCATION_ONFIELD)
		e3:SetValue(0xa05)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		tc1:RegisterEffect(e3)
		local e4=Effect.CreateEffect(tc2)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
		e4:SetCode(EFFECT_ADD_SETCODE)
		e4:SetRange(LOCATION_ONFIELD)
		e4:SetValue(0xa05)
		e4:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		tc2:RegisterEffect(e4)
		local e5=Effect.CreateEffect(tc1)
		e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
		e5:SetCode(EVENT_PRE_DAMAGE_CALCULATE)
		e5:SetRange(LOCATION_ONFIELD)
		e5:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e5:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		e5:SetOperation(Gacha3.btcoutertgop)
		tc1:RegisterEffect(e5)
end
function Gacha3.btcounterdesfilter(c)
	return c:IsReason(REASON_BATTLE)
end
function Gacha3.btcounterdescon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(Gacha3.btcounterdesfilter,1,nil)
end
function Gacha3.btcounterdesop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_BATTLE)
end
function Gacha3.btcoutertgop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local at=Duel.GetAttacker()
	Duel.CalculateDamage(at,c)
end