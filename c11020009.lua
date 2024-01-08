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
