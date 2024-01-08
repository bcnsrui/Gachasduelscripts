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
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e2:SetCode(EVENT_SPSUMMON_SUCCESS)
	e2:SetOperation(s.activate)
	c:RegisterEffect(e2)
end
function s.ftcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return Duel.GetFieldGroupCount(c:GetControler(),LOCATION_EXTRA,0,nil)>=4 and not c:IsSetCard(0xb07)
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
	
	local refill=Duel.GetMatchingGroup(nil,tp,LOCATION_GRAVE,0,nil)
	if Duel.GetMatchingGroupCount(nil,tp,LOCATION_DECK,0,nil)==0 then
	Duel.SendtoDeck(refill,nil,SEQ_DECKSHUFFLE,REASON_RULE)	end
	local g=Duel.GetDecktopGroup(tp,1)
	if #g<1 then return end
	local sg=g:Select(tp,1,1,nil)
	local op=Duel.SelectEffect(tp,{true,aux.Stringid(id,1)},{true,aux.Stringid(id,2)})
	if op==1 then
	Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
	elseif op==2 then end
end
function s.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local refill=Duel.GetMatchingGroup(nil,tp,LOCATION_GRAVE,0,nil)
	if Duel.GetMatchingGroupCount(nil,tp,LOCATION_DECK,0,nil)==0 then
	Duel.SendtoDeck(refill,nil,SEQ_DECKSHUFFLE,REASON_RULE)	end
	local g=Duel.GetDecktopGroup(tp,1)
	if #g<1 then return end
	local sg=g:Select(tp,1,1,nil)
	local op=Duel.SelectEffect(tp,{true,aux.Stringid(id,1)},{true,aux.Stringid(id,2)})
	if op==1 then
	Duel.Remove(sg,POS_FACEUP,REASON_EFFECT)
	elseif op==2 then end
end
