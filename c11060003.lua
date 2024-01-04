local s,id=GetID()
function s.initial_effect(c)
	Gacha2.UnitCharacter(c)
	Gacha3.DuelAtkUnitCharacter(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_BATTLED)
	e1:SetRange(LOCATION_ONFIELD)
	e1:SetCountLimit(1)
	e1:SetCondition(s.battlecon3)
	e1:SetTarget(s.battletg3)
	e1:SetOperation(s.battleop3)
	c:RegisterEffect(e1)
end
function s.battlecon3(e,tp,eg,ep,ev,re,r,rp)
	return (Duel.GetAttacker()==e:GetHandler() or e:GetHandler():IsSetCard(0xa04))
end
function s.spfilter3(c)
	return c:IsDefensePos() and c:IsLevelBelow(2)
end
function s.battletg3(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(s.spfilter3,tp,LOCATION_ONFIELD,0,1,e:GetHandler()) end
end
function s.battleop3(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.SelectMatchingCard(tp,s.spfilter3,tp,LOCATION_ONFIELD,0,0,1,nil)
	if #tc==0 then return end
	Duel.ChangePosition(tc,POS_FACEUP_ATTACK)
end