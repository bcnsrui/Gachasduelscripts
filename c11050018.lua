local s,id=GetID()
function s.initial_effect(c)
	Gacha2.UnitCharacter(c)
	Gacha3.DuelAtkUnitCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(id,0))
	e1:SetType(EFFECT_TYPE_XMATERIAL+EFFECT_TYPE_IGNITION)
	e1:SetCondition(s.ftcon)
	e1:SetOperation(s.ftop)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_SPSUM_PARAM)
	e2:SetRange(LOCATION_HAND)
	e2:SetTargetRange(POS_FACEUP_ATTACK,0)
	e2:SetCondition(s.sumcon)
	e2:SetOperation(s.sumop)
	c:RegisterEffect(e2)
end
function s.ftcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_EXTRA,0,nil)>=5 and not c:IsSetCard(0xb07)
end
function s.ftop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local fortune=c:GetOverlayGroup():FilterSelect(tp,Card.IsCode,1,1,nil,id)
	Duel.Remove(fortune,POS_FACEUP,REASON_EFFECT)
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_CANNOT_DISABLE)
	e1:SetCode(EFFECT_ADD_SETCODE)
	e1:SetRange(LOCATION_ONFIELD)
	e1:SetValue(0xb07)
	e1:SetReset(RESET_EVENT+RESETS_STANDARD+RESET_PHASE+PHASE_END)
	c:RegisterEffect(e1)
	
    local tc=Duel.GetMatchingGroup(nil,tp,LOCATION_EMZONE,0,nil):GetFirst()
    local deck=Duel.GetMatchingGroup(nil,tp,LOCATION_GRAVE,0,nil)
    if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then
    Duel.SendtoDeck(deck,nil,SEQ_DECKSHUFFLE,REASON_RULE) end
    local bg=Duel.GetDecktopGroup(tp,1)
    Duel.Overlay(tc,bg)
end
function s.summonfilter(c)
	return c:IsDefensePos()
end
function s.sumcon(e,c)
   if c==nil then return true end
    local tp=c:GetControler()
    return ((Duel.CheckRemoveOverlayCard(tp,1,0,c:GetLevel(),REASON_COST)
	and Duel.GetFieldGroupCount(e:GetHandler():GetControler(),LOCATION_HAND,0,nil)>=2)
	or Duel.IsExistingMatchingCard(s.summonfilter,tp,LOCATION_EMZONE,0,1,nil))
end
function s.sumop(e,tp,eg,ep,ev,re,r,rp,c)
	local c=e:GetHandler()
	local ct=Duel.GetMatchingGroup(Card.IsFaceup,tp,LOCATION_EXTRA,0,nil):GetFirst()
	if Duel.IsExistingMatchingCard(s.summonfilter,tp,LOCATION_EMZONE,0,1,nil) then return end
	local g=Duel.GetOverlayGroup(tp,1,0)
	local ag=g:Select(tp,c:GetLevel(),c:GetLevel(),nil)
	if not Duel.SelectYesNo(tp,aux.Stringid(11000001,2)) then
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetOperation(s.sumlimit)
	e1:SetReset(RESET_EVENT+RESET_TOHAND)
	c:RegisterEffect(e1)
	else 
	local g=Duel.SelectMatchingCard(tp,nil,tp,LOCATION_HAND,0,1,1,c)
	Duel.SendtoGrave(ag,REASON_RULE)
	Duel.SendtoGrave(g,REASON_RULE) end
end
function s.sumlimit(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	Duel.SendtoHand(c,nil,REASON_RULE)
end