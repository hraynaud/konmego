def exec_endorsement_query_v0(current_user, topic, hops)
  ActiveGraph::Base.query("
    Match p = (starter:Person {uuid: $uuid})-[:`KNOWS`*0..#{hops}]-(endorser:Person)-[e:ENDORSES]->(endorsee:Person)
    WHERE e.topic =~ $topic
    WITH p,e

    WHERE ALL(x IN NODES(p) WHERE SINGLE(y IN NODES(p) WHERE y = x))
    RETURN nodes(p) as all_paths, e",
                          topic: topic, uuid: current_user.uuid)
end
# ╒══════════════════════════════════════════════════════════════════════╤══════════════════════════════════════════════════╕
# │"all_paths"                                                           │"e"                                               │
# ╞══════════════════════════════════════════════════════════════════════╪══════════════════════════════════════════════════╡
# │[{"avatar_url":"","is_member":true,"name":"Herby Skillz","last_name":"│{"topic":"Basketball","status":0,"topic_status":0}│
# │Skillz","created_at":1706274473,"profile_image_url":"","password_diges│                                                  │
# │t":"$2a$12$V2DY15QypPJ3KsUqocdig.OhvE5ZEpXLNqJ.ZO00.FShhUN2Zt7Aq","fir│                                                  │
# │st_name":"Herby","uuid":"aad42a2f-6771-4f3d-9f94-22cea9e0282f","email"│                                                  │
# │:"foo1@mail.com"},{"avatar_url":"","is_member":true,"name":"Sar Skillz│                                                  │
# │","last_name":"Skillz","created_at":1706274474,"profile_image_url":"",│                                                  │
# │"password_digest":"$2a$12$zfEP7/oDLkSxcJuy4QNZBOogqwx0WNHeS.FkijLUOZwu│                                                  │
# │jQui0Ngea","first_name":"Sar","uuid":"6852c66f-ca6a-44eb-bc52-519f638a│                                                  │
# │9640","email":"foo6@mail.com"},{"avatar_url":"","is_member":true,"name│                                                  │
# │":"Elsa Skillz","last_name":"Skillz","created_at":1706274474,"profile_│                                                  │
# │image_url":"","password_digest":"$2a$12$iflP1gRMg4RwPUmlNXceRuRBe/AIXW│                                                  │
# │yFMc3BnzgFEXbPMTTaUEUz6","first_name":"Elsa","uuid":"d55b12b7-3e9d-4f4│                                                  │
# │4-a28e-78f50d0ea195","email":"foo7@mail.com"},{"avatar_url":"","is_mem│                                                  │
# │ber":true,"name":"Stan Skillz","last_name":"Skillz","created_at":17062│                                                  │
# │74477,"profile_image_url":"","password_digest":"$2a$12$Rtxz6ELdZmvdS/F│                                                  │
# │bB0Y8VO1v7RZZSIY.c1bw5fajGg2gpicoa0syu","first_name":"Stan","uuid":"41│                                                  │
# │91ddf8-975f-43d5-8170-21f87cc8c7bf","email":"foo15@mail.com"}]        │                                                  │
# ├──────────────────────────────────────────────────────────────────────┼──────────────────────────────────────────────────┤
# │[{"avatar_url":"","is_member":true,"name":"Herby Skillz","last_name":"│{"topic":"Basketball","status":0,"topic_status":0}│
# │Skillz","created_at":1706274473,"profile_image_url":"","password_diges│                                                  │
# │t":"$2a$12$V2DY15QypPJ3KsUqocdig.OhvE5ZEpXLNqJ.ZO00.FShhUN2Zt7Aq","fir│                                                  │
# │st_name":"Herby","uuid":"aad42a2f-6771-4f3d-9f94-22cea9e0282f","email"│                                                  │
# │:"foo1@mail.com"},{"avatar_url":"","is_member":true,"name":"Elsa Skill│                                                  │
# │z","last_name":"Skillz","created_at":1706274474,"profile_image_url":""│                                                  │
# │,"password_digest":"$2a$12$iflP1gRMg4RwPUmlNXceRuRBe/AIXWyFMc3BnzgFEXb│                                                  │
# │PMTTaUEUz6","first_name":"Elsa","uuid":"d55b12b7-3e9d-4f44-a28e-78f50d│                                                  │
# │0ea195","email":"foo7@mail.com"},{"avatar_url":"","is_member":true,"na│                                                  │
# │me":"Stan Skillz","last_name":"Skillz","created_at":1706274477,"profil│                                                  │
# │e_image_url":"","password_digest":"$2a$12$Rtxz6ELdZmvdS/FbB0Y8VO1v7RZZ│                                                  │
# │SIY.c1bw5fajGg2gpicoa0syu","first_name":"Stan","uuid":"4191ddf8-975f-4│                                                  │
# │3d5-8170-21f87cc8c7bf","email":"foo15@mail.com"}]                     │                                                  │
# └──────────────────────────────────────────────────────────────────────┴──────────────────────────────────────────────────┘

def exec_endorsement_query_v1(current_user, topic, hops)
  ActiveGraph::Base.query("
    MATCH p = allShortestPaths((starter:Person {uuid: $uuid})-[:`KNOWS`*0..#{hops}]-(endorsee:Person))
    WHERE ALL(x IN NODES(p)
    WHERE SINGLE(y IN NODES(p) WHERE y = x)) WITH p, endorsee
    MATCH (endorser)-[e:ENDORSES]-(endorsee:Person)
    WHERE e.topic =~ $topic AND endorsee IN NODES(p)
    WITH p, COLLECT(DISTINCT e) AS pathEndorsements
    RETURN nodes(p) AS all_paths, pathEndorsements",
                          topic: topic, uuid: current_user.uuid)
end

# ╒══════════════════════════════════════════════════════════════════════╤════════════════════════════════════════════════════╕
# │"all_paths"                                                           │"pathEndorsements"                                  │
# ╞══════════════════════════════════════════════════════════════════════╪════════════════════════════════════════════════════╡
# │[{"avatar_url":"","is_member":true,"name":"Herby Skillz","last_name":"│[{"topic":"Basketball","status":0,"topic_status":0}]│
# │Skillz","created_at":1706274473,"profile_image_url":"","password_diges│                                                    │
# │t":"$2a$12$V2DY15QypPJ3KsUqocdig.OhvE5ZEpXLNqJ.ZO00.FShhUN2Zt7Aq","fir│                                                    │
# │st_name":"Herby","uuid":"aad42a2f-6771-4f3d-9f94-22cea9e0282f","email"│                                                    │
# │:"foo1@mail.com"},{"avatar_url":"","is_member":true,"name":"Elsa Skill│                                                    │
# │z","last_name":"Skillz","created_at":1706274474,"profile_image_url":""│                                                    │
# │,"password_digest":"$2a$12$iflP1gRMg4RwPUmlNXceRuRBe/AIXWyFMc3BnzgFEXb│                                                    │
# │PMTTaUEUz6","first_name":"Elsa","uuid":"d55b12b7-3e9d-4f44-a28e-78f50d│                                                    │
# │0ea195","email":"foo7@mail.com"}]                                     │                                                    │
# ├──────────────────────────────────────────────────────────────────────┼────────────────────────────────────────────────────┤
# │[{"avatar_url":"","is_member":true,"name":"Herby Skillz","last_name":"│[{"topic":"Basketball","status":0,"topic_status":0}]│
# │Skillz","created_at":1706274473,"profile_image_url":"","password_diges│                                                    │
# │t":"$2a$12$V2DY15QypPJ3KsUqocdig.OhvE5ZEpXLNqJ.ZO00.FShhUN2Zt7Aq","fir│                                                    │
# │st_name":"Herby","uuid":"aad42a2f-6771-4f3d-9f94-22cea9e0282f","email"│                                                    │
# │:"foo1@mail.com"},{"avatar_url":"","is_member":true,"name":"Elsa Skill│                                                    │
# │z","last_name":"Skillz","created_at":1706274474,"profile_image_url":""│                                                    │
# │,"password_digest":"$2a$12$iflP1gRMg4RwPUmlNXceRuRBe/AIXWyFMc3BnzgFEXb│                                                    │
# │PMTTaUEUz6","first_name":"Elsa","uuid":"d55b12b7-3e9d-4f44-a28e-78f50d│                                                    │
# │0ea195","email":"foo7@mail.com"},{"avatar_url":"","is_member":true,"na│                                                    │
# │me":"Stan Skillz","last_name":"Skillz","created_at":1706274477,"profil│                                                    │
# │e_image_url":"","password_digest":"$2a$12$Rtxz6ELdZmvdS/FbB0Y8VO1v7RZZ│                                                    │
# │SIY.c1bw5fajGg2gpicoa0syu","first_name":"Stan","uuid":"4191ddf8-975f-4│                                                    │
# │3d5-8170-21f87cc8c7bf","email":"foo15@mail.com"}]                     │                                                    │
# └──────────────────────────────────────────────────────────────────────┴────────────────────────────────────────────────────┘

def exec_endorsement_query_v2(current_user, topic, hops)
  ActiveGraph::Base.query("
  MATCH p = allShortestPaths((starter:Person {uuid: $uuid})-[:`KNOWS`*0..#{hops}]-(endorser:Person))
  WHERE ALL(x IN NODES(p) WHERE SINGLE(y IN NODES(p) WHERE y = x))
  WITH p, endorser
  MATCH (endorser)-[e:ENDORSES]->(endorsee:Person)
  WHERE e.topic =~ $topic
  RETURN DISTINCT e, nodes(p) AS all_paths",
                          topic: topic, uuid: current_user.uuid)
end

def exec_endorsement_query_v3(current_user, topic, hops)
  ActiveGraph::Base.query("
MATCH p = allShortestPaths((starter:Person {uuid: $uuid})-[:`KNOWS`*0..#{hops}]-(endorser:Person))
WHERE ALL(node IN NODES(p) WHERE SINGLE(y IN NODES(p) WHERE y = node))
WITH p, endorser
MATCH (endorser)-[e:ENDORSES]->(endorsee:Person)
WHERE e.topic =~ $topic
RETURN DISTINCT e, nodes(p) + endorsee AS all_paths",
                          topic: topic, uuid: current_user.uuid)
end

def exec_endorsement_query_v4(current_user, topic, hops)
  ActiveGraph::Base.query("
  MATCH p = allShortestPaths((starter:Person {uuid: $uuid})-[:`KNOWS`*0..#{hops}]-(endorser:Person))
  WHERE ALL(node IN NODES(p) WHERE SINGLE(y IN NODES(p) WHERE y = node))
  WITH p, endorser
  MATCH (endorser)-[e:ENDORSES]->(endorsee:Person)
  WHERE e.topic =~ $topic
  RETURN DISTINCT e, nodes(p)  AS all_paths",
                          topic: topic, uuid: current_user.uuid)
end

def exec_endorsement_query_v5(current_user, topic, hops)
  ActiveGraph::Base.query("
  MATCH p = allShortestPaths((starter:Person {uuid: $uuid})-[:`KNOWS`|`ENDORSES`*0..#{hops}]-(endorser:Person))
  WHERE ALL(node IN NODES(p) WHERE SINGLE(y IN NODES(p) WHERE y = node))
  WITH p, endorser
  MATCH (endorser)-[e:ENDORSES]->(endorsee:Person)
  WHERE e.topic =~ $topic
  RETURN DISTINCT e, nodes(p) + endorsee AS all_paths, length(p) AS pathLength
  ORDER BY pathLength ASC",
                          topic: topic, uuid: current_user.uuid)
end
