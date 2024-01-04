local s,id=GetID()
function s.initial_effect(c)
	Gacha2.UnitCharacter(c)
	Gacha3.DuelAtkUnitCharacter(c)
	local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
    e1:SetCode(EVENT_ATTACK_ANNOUNCE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCondition(s.battlecon)
	e1:SetOperation(s.battleop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EFFECT_ADD_SETCODE)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCondition(s.hintcon)
	e2:SetValue(0xa08)
	c:RegisterEffect(e2)
end
function s.battlecon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttackTarget()~=nil and Duel.IsExistingMatchingCard(s.zerofilter,tp,LOCATION_ONFIELD,0,1,e:GetHandler())
end
function s.hintcon(e)
	return Duel.IsExistingMatchingCard(s.zerofilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,e:GetHandler())
end
function s.zerofilter(c)
	return c:IsAttackPos() and c:IsLevelAbove(4) and not c:IsSetCard(0xa01)
end
function s.battleop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DEFENSE_ATTACK)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetValue(1)
		e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL)
		c:RegisterEffect(e1)
		local g=Duel.SelectMatchingCard(tp,s.zerofilter,tp,LOCATION_ONFIELD,0,1,1,c)
		local tc=g:GetFirst()
		Duel.ChangePosition(c,POS_FACEUP_DEFENSE)
		Duel.ChangePosition(tc,POS_FACEUP_DEFENSE)	
		local def=tc:GetDefense()
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		e2:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE_CAL)
		e2:SetValue(def)
		c:RegisterEffect(e2)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e3:SetCode(EFFECT_ADD_SETCODE)
		e3:SetRange(LOCATION_ONFIELD)
		e3:SetValue(0xa04)
		e3:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		c:RegisterEffect(e3)
		local e4=Effect.CreateEffect(tc)
		e4:SetType(EFFECT_TYPE_SINGLE)
		e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e4:SetCode(EFFECT_ADD_SETCODE)
		e4:SetRange(LOCATION_ONFIELD)
		e4:SetValue(0xa04)
		e4:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		tc:RegisterEffect(e4)
		local e5=Effect.CreateEffect(c)
		e5:SetType(EFFECT_TYPE_SINGLE)
		e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
		e5:SetCode(EFFECT_ADD_SETCODE)
		e5:SetRange(LOCATION_ONFIELD)
		e5:SetValue(0xa02)
		e5:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_DAMAGE)
		c:RegisterEffect(e5)
		if tc:IsCode(11060001) then
		Gacha3.UrsaUnit(e,tp,eg,ep,ev,re,r,rp)	end
		if tc:IsCode(11060006) and tc:IsSetCard(0xb04) then
		Gacha3.RoseUnit(e,tp,eg,ep,ev,re,r,rp)	end
end