WITH 'http://koderman.de/nodes.json' AS url
CALL apoc.load.json(url, '$[?(@.type == "bp_requirement")]') YIELD value
UNWIND value AS node

MERGE (r:BsiRequirement {extId: node.extId})
SET r.name = node.name
SET r.text = node.text
SET r.gsid = node.gsid;


WITH 'http://koderman.de/nodes.json' AS url
CALL apoc.load.json(url, '$[?(@.type == "bp_safeguard")]') YIELD value
UNWIND value AS node

MERGE (r:BsiSafeguard {extId: node.extId})
SET r.name = node.name
SET r.text = node.text
SET r.gsid = node.gsid;


WITH 'http://koderman.de/nodes.json' AS url
CALL apoc.load.json(url, '$[?(@.type == "bp_threat")]') YIELD value
UNWIND value AS node

MERGE (r:BsiThreat {extId: node.extId})
SET r.name = node.name
SET r.text = node.text
SET r.gsid = node.gsid;


WITH 'http://koderman.de/nodes.json' AS url
CALL apoc.load.json(url, '$[?(@.type == "bp_requirement_group")]') YIELD value
UNWIND value AS node

MERGE (r:BsiGroup {extId: node.extId})
SET r.name = node.name
SET r.text = node.text
SET r.gsid = node.gsid;


WITH 'http://koderman.de/nodes.json' AS url
CALL apoc.load.json(url, '$[?(@.type == "bp_safeguard_group")]') YIELD value
UNWIND value AS node

MERGE (r:BsiGroup {extId: node.extId})
SET r.name = node.name
SET r.text = node.text
SET r.gsid = node.gsid;


WITH 'http://koderman.de/nodes.json' AS url
CALL apoc.load.json(url, '$[?(@.type == "bp_threat_group")]') YIELD value
UNWIND value AS node

MERGE (r:BsiGroup {extId: node.extId})
SET r.name = node.name
SET r.text = node.text
SET r.gsid = node.gsid;


CREATE INDEX g_extid_idx IF NOT EXISTS FOR (n:BsiGroup) ON (n.extId);
CREATE INDEX s_extid_idx IF NOT EXISTS FOR (n:BsiSafeguard) ON (n.extId);
CREATE INDEX r_extid_idx IF NOT EXISTS FOR (n:BsiRequirement) ON (n.extId);
CREATE INDEX t_extid_idx IF NOT EXISTS FOR (n:BsiThreat) ON (n.extId);


# These relations are an error in the catalog:
#WITH 'http://koderman.de/rels.json' AS url
#CALL apoc.load.json(url, '$[?(@.linkType == "rel_bp_requirement_bp_requirement")]') YIELD value
#UNWIND value AS rel
#
#MATCH (n1)
#WHERE n1.extId = rel.from
#MATCH (n2)
#WHERE n2.extId = rel.to
#
#MERGE (n1)-[r:RELATED]->(n2)
#SET r.type = rel.linkType;


WITH 'http://koderman.de/rels.json' AS url
CALL apoc.load.json(url, '$[?(@.linkType == "rel_bp_requirement_bp_safeguard")]') YIELD value
UNWIND value AS rel

MATCH (n1)
WHERE n1.extId = rel.from
MATCH (n2)
WHERE n2.extId = rel.to

MERGE (n1)-[r:REQUIRED_BY_SAFEGUARD]->(n2);


WITH 'http://koderman.de/rels.json' AS url
CALL apoc.load.json(url, '$[?(@.linkType == "rel_bp_requirement_bp_threat")]') YIELD value
UNWIND value AS rel

MATCH (n1)
WHERE n1.extId = rel.from
MATCH (n2)
WHERE n2.extId = rel.to

MERGE (n1)-[r:REQUIRED_BY_THREAT]->(n2);


WITH 'http://koderman.de/child_rels-l1.json' AS url
CALL apoc.load.json(url, '$') YIELD value
UNWIND value AS rel

MATCH (p)
WHERE p.extId = rel.parentId
MATCH (c)
WHERE c.extId = rel.childId

MERGE (p)-[r:CONTAINS]->(c);


WITH 'http://koderman.de/child_rels-l2.json' AS url
CALL apoc.load.json(url, '$') YIELD value
UNWIND value AS rel

MATCH (p)
WHERE p.extId = rel.parentId
MATCH (c)
WHERE c.extId = rel.childId

MERGE (p)-[r:CONTAINS]->(c);


WITH 'http://koderman.de/child_rels-l3.json' AS url
CALL apoc.load.json(url, '$') YIELD value
UNWIND value AS rel

MATCH (p)
WHERE p.extId = rel.parentId
MATCH (c)
WHERE c.extId = rel.childId

MERGE (p)-[r:CONTAINS]->(c);


WITH 'http://koderman.de/child_rels-l4.json' AS url
CALL apoc.load.json(url, '$') YIELD value
UNWIND value AS rel

MATCH (p)
WHERE p.extId = rel.parentId
MATCH (c)
WHERE c.extId = rel.childId

MERGE (p)-[r:CONTAINS]->(c);


WITH 'http://koderman.de/child_rels-l5.json' AS url
CALL apoc.load.json(url, '$') YIELD value
UNWIND value AS rel

MATCH (p)
WHERE p.extId = rel.parentId
MATCH (c)
WHERE c.extId = rel.childId

MERGE (p)-[r:CONTAINS]->(c);
