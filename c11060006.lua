local s,id=GetID()
function s.initial_effect(c)
	Gacha2.UnitCharacter(c)
	Gacha3.DuelAtkUnitCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(s.limitcon)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetCondition(s.fccondition)
	e2:SetValue(1000)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
end
function s.limitcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.IsExistingMatchingCard(aux.FaceupFilter(Card.IsCode,11000002),tp,LOCATION_FZONE,0,1,nil)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local limit=Duel.GetFieldGroup(tp,LOCATION_FZONE,0)
	Duel.SendtoGrave(limit,REASON_EFFECT)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetCode(EFFECT_ADD_SETCODE)
	e1:SetRange(LOCATION_ONFIELD)
	e1:SetValue(0xb04)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCode(EVENT_DAMAGE)
	e2:SetCondition(s.btdamcon)
	e2:SetOperation(s.btdamop)
	c:RegisterEffect(e2)
end
function s.fcfllter(c)
	return not c:IsLocation(LOCATION_EMZONE+LOCATION_FZONE)
end
function s.fccondition(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetMatchingGroupCount(s.fcfllter,tp,0,LOCATION_ONFIELD,nil)>=5 and Duel.GetTurnPlayer()==tp
end
function s.btdamcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetAttacker()==e:GetHandler()
end
function s.btdamop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetMatchingGroupCount(s.fcfllter,tp,0,LOCATION_ONFIELD,nil)>=5 
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