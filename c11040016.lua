local s,id=GetID()
function s.initial_effect(c)
	Gacha2.UnitCharacter(c)
	Gacha3.DuelAtkUnitCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetOperation(s.drawop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_TOHAND+CATEGORY_SEARCH)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetCondition(s.limitcon)
	e2:SetOperation(s.activate)
	c:RegisterEffect(e2)
end
function s.drawop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(Card.IsFacedown,tp,LOCATION_REMOVED,0,nil)
	local ag=g:Filter(Card.IsSetCard,nil,0xa03)
	
	if #ag==0 and #g>0 then
	sg1=g:RandomSelect(tp,1)	
	Duel.SendtoDeck(sg1,nil,0,REASON_RULE)
	Duel.Draw(tp,1,REASON_RULE) end

	if #ag==0 and #g==0 then
	local g2=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_REMOVED,0,nil)
	Duel.SendtoGrave(g2,REASON_RULE)
	Duel.Remove(g2,POS_FACEDOWN,REASON_RULE)
	sg2=g2:RandomSelect(tp,1)
	if #sg2==0 then return end
	Duel.SendtoDeck(sg2,nil,0,REASON_RULE)
	Duel.Draw(tp,1,REASON_RULE) end
	
	if #ag>0 then
	Duel.SendtoHand(ag:GetFirst(),nil,REASON_RULE) end
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
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_ONFIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
    e2:SetCondition(s.discon)
	e2:SetValue(4000)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENSE)
	c:RegisterEffect(e3)
end
function s.discon(e,tp,eg,ep,ev,re,r,rp)
    return Duel.GetFieldGroupCount(e:GetHandler():GetControler(),LOCATION_HAND,0,nil)>=4
end