function worldEndContactCallback(fixture_a, fixture_b, contact)
    local entity_a = fixture_a:getUserData()
    local entity_b = fixture_b:getUserData()
    if entity_a.end_contact then entity_a:end_contact() end
    if entity_b.end_contact then entity_b:end_contact() end
end
