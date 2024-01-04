local s,id=GetID()
function s.initial_effect(c)
	Gacha2.UnitCharacter(c)
	Gacha3.DuelAtkUnitCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_ONFIELD)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetCondition(s.fccondition)
	e1:SetValue(3000)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e2)
end
function s.fcfllter(c)
	return not c:IsLocation(LOCATION_EMZONE+LOCATION_FZONE)
end
function s.fccondition(e)
	local tp=e:GetHandlerPlayer()
	return Duel.GetMatchingGroupCount(s.fcfllter,tp,0,LOCATION_ONFIELD,nil)>=5
	or Duel.GetMatchingGroupCount(Card.IsSetCard,tp,LOCATION_ONFIELD,0,nil,0xa10)>=1
end