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
	if not re:GetHandler():IsCode(11050010) then
	local deck=Duel.GetMatchingGroup(nil,tp,LOCATION_DECK,0,nil)
	local refill=Duel.GetMatchingGroup(nil,tp,LOCATION_GRAVE,0,nil)
	if Duel.GetMatchingGroupCount(nil,tp,LOCATION_DECK,0,nil)<3 then
	Duel.SendtoGrave(deck,REASON_RULE)
	Duel.SendtoDeck(refill,nil,SEQ_DECKSHUFFLE,REASON_RULE)
	Duel.SendtoDeck(deck,nil,0,REASON_RULE)	end
	local g=Duel.GetDecktopGroup(tp,3)
	if #g<3 then return end
	Duel.ConfirmCards(1-tp,g)
	local sg=g:Select(tp,2,2,nil)
	Duel.Remove(sg,POS_FACEDOWN,REASON_EFFECT)
	g:Sub(sg)
	Duel.SendtoGrave(g,REASON_EFFECT) end
end