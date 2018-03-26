public class ObjectAndFieldsAccessCheck {

     public static Boolean checkAccessToObjectFields(String objectName,String accessType,List<String> fieldsToCheck){
        
        SObjectType schemaType = Schema.getGlobalDescribe().get(objectName);
        Map<String, SObjectField> objectFieldMap = schemaType.getDescribe().fields.getMap();

        if(accessType == 'isAccessible'){
            for (String fieldToCheck : fieldsToCheck) {
                if (!objectFieldMap.get(fieldToCheck).getDescribe().isAccessible()) {
                    return false;
                }
            }
        }
        
        if(accessType == 'isCreateable'){
            for (String fieldToCheck : fieldsToCheck) {
                if (!objectFieldMap.get(fieldToCheck).getDescribe().isCreateable()) {
                    return false;
                }
            }
        }
        if(accessType == 'isUpdateable'){
            for (String fieldToCheck : fieldsToCheck) {
                if (!objectFieldMap.get(fieldToCheck).getDescribe().isUpdateable()) {
                    return false;
                }
            }
        }
        
        return true;
    }

    public static Boolean checkAccessToObject(String objectName,String accessType){
        
        if(accessType == 'isAccessible'){
            if(!Schema.getGlobalDescribe().get(objectName).getDescribe().isAccessible()){
                return false;
            }
        }
        
        if(accessType == 'isCreateable'){
            if(!Schema.getGlobalDescribe().get(objectName).getDescribe().isCreateable()){
                return false;
            }
        }
        
        if(accessType == 'isUpdateable'){
            if(!Schema.getGlobalDescribe().get(objectName).getDescribe().isUpdateable()){
                return false;
            }
        }
        
        if(accessType == 'isDeletable'){
            if(!Schema.getGlobalDescribe().get(objectName).getDescribe().isDeletable()){
                return false;
            }
        }
        return true;
    }
}