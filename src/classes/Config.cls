public class Config {
    public static final Integer countRecordsForBookPage = 10;

    public static String errorMsg(Integer errCode){
        Map<Integer,String> errors= new Map<Integer,String> {0=>'Do not have access to Genre fields or object',
        1=>'Do not have access to edit record',
        2=>'Somthing wrong with Record',
        3=>'Do not have access to Author fields or object',
        4=>'Add error',
        5=>'Do not have access to delete',
        6=>'Delete error'};

        return errors.get(errCode);
    }
}