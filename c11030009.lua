local s,id=GetID()
function s.initial_effect(c)
	Gacha2.UnitCharacter(c)
	Gacha3.DuelAtkUnitCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetCondition(s.battlecon)
	e1:SetOperation(s.activate)
	c:RegisterEffect(e1)
end
function s.fcfllter(c)
	return not c:IsLocation(LOCATION_EMZONE+LOCATION_FZONE)
end
function s.fcfllter2(c)
	return c:IsSetCard(0xa10)
end
function s.battlecon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return (Duel.GetMatchingGroupCount(s.fcfllter,tp,0,LOCATION_ONFIELD,nil)>Duel.GetMatchingGroupCount(s.fcfllter,tp,LOCATION_ONFIELD,0,nil)
	or (Duel.GetMatchingGroupCount(s.fcfllter2,tp,LOCATION_ONFIELD,0,nil)>=1 
	and Duel.GetMatchingGroupCount(s.fcfllter,tp,LOCATION_ONFIELD,0,nil)<=4))
	and not re:GetHandler():IsCode(11050010)
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
    local tc=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
    local deck=Duel.GetMatchingGroup(nil,tp,LOCATION_GRAVE,0,nil)
    if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then
    Duel.SendtoDeck(deck,nil,SEQ_DECKSHUFFLE,REASON_RULE) end
    local bg=Duel.GetDecktopGroup(tp,1)
    Duel.Overlay(tc,bg)
end