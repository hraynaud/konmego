// Constraints

CREATE CONSTRAINT person_uuid_uniq IF NOT EXISTS FOR (n:Person) REQUIRE (n.uuid) IS UNIQUE;
CREATE CONSTRAINT constraint_eae8a740 IF NOT EXISTS FOR (n:Endorsement) REQUIRE (n.uuid) IS UNIQUE;
CREATE CONSTRAINT project_uuid_uniq IF NOT EXISTS FOR (n:Project) REQUIRE (n.uuid) IS UNIQUE;
CREATE CONSTRAINT topic_uuid_uniq IF NOT EXISTS FOR (n:Topic) REQUIRE (n.uuid) IS UNIQUE;
CREATE CONSTRAINT registration_uuid_uniq IF NOT EXISTS FOR (n:Registration) REQUIRE (n.uuid) IS UNIQUE;
CREATE CONSTRAINT comment_uuid_uniq IF NOT EXISTS FOR (n:Comment) REQUIRE (n.uuid) IS UNIQUE;
CREATE CONSTRAINT obstacle_uuid_uniq IF NOT EXISTS FOR (n:Obstacle) REQUIRE (n.uuid) IS UNIQUE;
CREATE CONSTRAINT indentoty_uuid_uniq IF NOT EXISTS FOR (n:Identity) REQUIRE (n.uuid) IS UNIQUE;
CREATE CONSTRAINT obstacle_category_uuid_uniq IF NOT EXISTS FOR (n:ObstacleCategory) REQUIRE (n.uuid) IS UNIQUE;
CREATE CONSTRAINT activity_uuid_uniq IF NOT EXISTS FOR (n:Activity) REQUIRE (n.uuid) IS UNIQUE;
CREATE CONSTRAINT invite_uuid_uniq IF NOT EXISTS FOR (n:Invite) REQUIRE (n.uuid) IS UNIQUE;
CREATE CONSTRAINT post_uuid_uniq IF NOT EXISTS FOR (n:Post) REQUIRE (n.uuid) IS UNIQUE;

// Indexes
CREATE INDEX endorsement_endorsement_type IF NOT EXISTS FOR (n:Endorsement) ON (n.type);
CREATE INDEX endorsement_endorsement_status IF NOT EXISTS FOR (n:Endorsement) ON (n.status);
CREATE INDEX person_person_is_member IF NOT EXISTS FOR (n:Person) ON (n.is_member);
CREATE INDEX project_project_status IF NOT EXISTS FOR (n:Project) ON (n.status);
CREATE INDEX project_project_visibility IF NOT EXISTS FOR (n:Project) ON (n.visibility);
CREATE VECTOR INDEX endorsementText IF NOT EXISTS FOR (n:Endorsement) ON (n.embeddings) OPTIONS {vector.dimensions: 1024, vector.similarity_function: 'COSINE'};