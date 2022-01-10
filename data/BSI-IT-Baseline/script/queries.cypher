
# find top level groups:
MATCH (g:BsiGroup) WHERE NOT (:BsiGroup)-[:CONTAINS]->(g) RETURN g;

# show groups that have the most treats (by paths to them, not disstcint
# threats):
MATCH p=(g1:BsiGroup)-[*1..4]->(t:BsiThreat) 
RETURN g1.gsid, g1.name, count(p) as numRequired
ORDER by numRequired DESC
LIMIT 10;


