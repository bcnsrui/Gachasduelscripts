local s,id=GetID()
function s.initial_effect(c)
	Gacha2.UnitCharacter(c)
	Gacha3.DuelAtkUnitCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_TOHAND)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_PHASE+PHASE_END)
	e1:SetProperty(EFFECT_FLAG_REPEAT)
	e1:SetCountLimit(1)
	e1:SetRange(LOCATION_ONFIELD)
	e1:SetCondition(s.tdcon)
	e1:SetOperation(s.tdop)
	c:RegisterEffect(e1)
end
function s.tdcon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()==1-tp and e:GetHandler():IsDefensePos()
end
function s.tdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.SendtoHand(e:GetHandler(),nil,REASON_EFFECT)
	Duel.ConfirmCards(1-tp,e:GetHandler())
	local g=Duel.GetDecktopGroup(tp,1)
	Duel.Remove(g,POS_FACEUP,REASON_EFFECT)
end