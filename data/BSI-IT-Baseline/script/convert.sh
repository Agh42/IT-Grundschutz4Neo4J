
# prepare relations:
xq '."ns3:syncRequest".syncData.syncLink[]| [{from: .dependant, to: .dependency, linkType: .relationId}]' src/verinice.xml > build/rels.json

# convert xml to json:
cat src/verinice.xml | xq . > build/verinice.json

# prepare nodes:
jq '.. | .children? | select(.) | .[] | .extId? as $extid | .extObjectType as $type | .syncAttribute? |  map(select(.name|contains("_name"))|.value)[0] as $name | map(select(.name|contains("browser_content"))|.value)[0] as $text | map(select(.name|contains("_id"))|.value)[0] as $id | [{name: $name, text: $text, gsid: $id, extId: $extid, type: $type}]  ' build/verinice.json >  build/nodes.json 

# parent-child relations: level 1:
jq '."ns3:syncRequest".syncData.syncObject | .extId? as $extId | .extObjectType as $parentType | .children[] | .extId as $childId | .extObjectType as $childType | {parentId: $extId, parentType: $parentType, childId: $childId, childType: $childType}' build/verinice.json > build/child_rels-l1.json

# level 2:
jq '."ns3:syncRequest".syncData.syncObject.children[] | .extId as $parentId | .extObjectType as $parentType | .children[] |  .extId? as $childId | .extObjectType as $childType | {parentId: $parentId, parentType: $parentType, childId: $childId, childType: $childType}' build/verinice.json > build/child_rels-l2.json

# level 3:
jq '."ns3:syncRequest".syncData.syncObject.children[].children[] |  .extId? as $parentId | .extObjectType as $parentType | .children[] | .extId as $childId | .extObjectType as $childType | {parentId: $parentId, parentType: $parentType, childId: $childId, childType: $childType}' build/verinice.json > build/child-rels-l3.json

# level 4:
jq '."ns3:syncRequest".syncData.syncObject.children[].children[].children? | select(.) | .[] | select(.) | .extId as $parentId | .extObjectType as $parentType | .children? | select(.) | .[] | select(.) | .extId? as $childId | .extObjectType? as $childType | {parentId: $parentId, parentType: $parentType, childId: $childId, childType: $childType}' build/verinice.json > build/child_rels-l4.json

# level 5:
jq '."ns3:syncRequest".syncData.syncObject.children[].children[].children? | select(.) | .[] | select(.) | .children? | select(.) | .[] | select(.) | .extId? as $parentId | .extObjectType? as $parentType | .children? | select(.) | .[] | select(.) | .extId? as $childId | .extObjectType? as $childType | {parentId: $parentId, parentType: $parentType, childId: $childId, childType: $childType}' build/verinice.json > build/child_rels-l5.json

