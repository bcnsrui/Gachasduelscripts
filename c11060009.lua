local s,id=GetID()
function s.initial_effect(c)
	Gacha2.UnitCharacter(c)
	Gacha3.DuelAtkUnitCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_ADD_SETCODE)
	e1:SetRange(LOCATION_ONFIELD)
	e1:SetTargetRange(0,LOCATION_ONFIELD)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsLevelBelow,2))
	e1:SetValue(0xa12)
	c:RegisterEffect(e1)
end