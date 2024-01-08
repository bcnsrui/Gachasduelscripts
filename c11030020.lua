local s,id=GetID()
function s.initial_effect(c)
	Gacha2.UnitCharacter(c)
	Gacha3.DuelAtkUnitCharacter(c)
	
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local deck=Duel.GetMatchingGroup(nil,tp,LOCATION_DECK,0,nil)
	local refill=Duel.GetMatchingGroup(nil,tp,LOCATION_GRAVE,0,nil)
	if Duel.GetMatchingGroupCount(nil,tp,LOCATION_DECK,0,nil)<2 then
	Duel.SendtoGrave(deck,REASON_RULE)
	Duel.SendtoDeck(refill,nil,SEQ_DECKSHUFFLE,REASON_RULE)
	Duel.SendtoDeck(deck,nil,0,REASON_RULE)	end
	local g=Duel.GetDecktopGroup(tp,2)
	if #g<2 then return end
	local sg=g:Select(tp,1,1,nil)
	Duel.SendtoDeck(sg,nil,0,REASON_RULE)
	g:Sub(sg)	
	Duel.SendtoGrave(g,REASON_EFFECT)
end