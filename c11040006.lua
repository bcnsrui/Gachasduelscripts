local s,id=GetID()
function s.initial_effect(c)
	Gacha2.UnitCharacter(c)
	Gacha3.DuelAtkUnitCharacter(c)
	
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetProperty(EFFECT_FLAG_DELAY)
    e1:SetCode(EVENT_BATTLED)
	e1:SetRange(LOCATION_ONFIELD)
	e1:SetCountLimit(1)
	e1:SetCondition(s.battlecon)
	e1:SetOperation(s.battleop)
	c:RegisterEffect(e1)
end
function s.battlecon(e,tp,eg,ep,ev,re,r,rp)
    return e:GetHandler():IsSetCard(0xa04)
end
function s.battleop(e,tp,eg,ep,ev,re,r,rp)
    Duel.ChangePosition(e:GetHandler(),POS_FACEUP_ATTACK)
end