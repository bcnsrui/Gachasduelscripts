local s,id=GetID()
function s.initial_effect(c)
	Gacha2.UnitCharacter(c)
	Gacha3.DuelAtkUnitCharacter(c)
	local e1=Effect.CreateEffect(c)
    e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_ONFIELD)
	e1:SetCountLimit(1)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local refill=Duel.GetMatchingGroup(nil,tp,LOCATION_GRAVE,0,nil)
	if Duel.GetMatchingGroupCount(nil,tp,LOCATION_DECK,0,nil)==0 then
	Duel.SendtoDeck(refill,nil,SEQ_DECKSHUFFLE,REASON_RULE)	end
	local g=Duel.GetDecktopGroup(tp,1)
	Duel.ConfirmCards(1-tp,g)
	Duel.SendtoDeck(g,nil,0,REASON_RULE)
	local tc=g:GetFirst()
	if tc:IsLevelBelow(4) then
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
	
	else 
	local e1=Effect.CreateEffect(e:GetHandler())
    e1:SetType(EFFECT_TYPE_SINGLE)
    e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e1:SetRange(LOCATION_ONFIELD)
    e1:SetCode(EFFECT_UPDATE_ATTACK)
    e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
    e1:SetValue(2000)
    c:RegisterEffect(e1)
    local e2=e1:Clone()
    e2:SetCode(EFFECT_UPDATE_DEFENSE)
    c:RegisterEffect(e2) end
end