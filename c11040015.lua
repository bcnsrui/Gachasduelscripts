local s,id=GetID()
function s.initial_effect(c)
	Gacha2.UnitCharacter(c)
	Gacha3.DuelAtkUnitCharacter(c)
	
	local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_ONFIELD)
	e1:SetCountLimit(1)
	e1:SetCondition(s.condition)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.fllter(c)
	return not c:IsLocation(LOCATION_EMZONE+LOCATION_FZONE)
end
function s.condition(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetMatchingGroupCount(s.fllter,tp,0,LOCATION_ONFIELD,nil)>=4
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
	local e1=Effect.CreateEffect(tc)
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_ADD_SETCODE)
    e1:SetRange(LOCATION_ONFIELD)
    e1:SetReset(RESET_PHASE+PHASE_END)
    e1:SetValue(0xa10)
    tc:RegisterEffect(e1)
end