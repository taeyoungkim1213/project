package kr.co.util;

import java.io.File;
import java.util.Arrays;
import java.util.List;

import lombok.extern.java.Log;
@Log
public class FileUtil {
    // 이미지 확장자 목록
    private static final List<String> allowedImageExtensions = Arrays.asList("jpg", "jpeg", "png", "gif");
    // 파일이 이미지 파일인지 확인하는 메서드
    public static boolean isImageFile(String fileName) {
        String fileExtension = getFileExtension(fileName);
        return allowedImageExtensions.contains(fileExtension.toLowerCase());
    }

    // 파일명에서 확장자를 추출하는 메서드
    private static String getFileExtension(String fileName) {
        int dotIndex = fileName.lastIndexOf(".");
        if (dotIndex > 0) {
            return fileName.substring(dotIndex + 1);
        }
        return "";
    }




// 파일이 존재하는지 확인하는 메서드

    //fileName = realPath + orignalName
    public static boolean isThere(String fileName) {
        //String을 File객체로 변환후 존재 유무 확인
        return convertFile(fileName).exists();
    }
    //String을 File객체로 변환해주는 메소드
    public static File convertFile(String fileName){
        return new File(fileName);
    }

    //중복된 파일명인 경우 파일명 뒤에 cnt를 붙여 처리하는 메솓,
    //fileName = realPath+ fileNmae
    public static String duplicateProcess(String fileName){
        int cnt = 1;
        String changeFileName = null;

        // 파일명에 확장자가 있는지 확인
        int insertPoint = fileName.lastIndexOf(".");

        // 확장자가 없는 경우
        if (insertPoint == -1) {
            changeFileName = fileName + cnt;
        } else {
            while (true) {
                StringBuilder sb = new StringBuilder(fileName);
                changeFileName = sb.insert(insertPoint, cnt++).toString();

                if (!isThere(changeFileName)) {
                    return changeFileName;
                }
            }
        }

        return changeFileName;
    }
//   public static String duplicateProcess(String fileName){
//        //중복처리를 위한 카운트 선언
//       int cnt = 1;
//       String changeFileNmae = null;
//       //삽입할 위치를 미리 구한다
//       //realPath + fileName.확장자 //.으로 잘라내서 앞에 숫자 붙이기
//
//
//
//       int insertPoint = fileName.lastIndexOf(".");
//       //중복이 되지않는 파일 이름 나올떄 까지 무한반복
//       while (true){
//           //새로운 파일명 만들기
//           //StringBuilder 는 조립 해서 끼워 넣기 가능
//           //insert로 . 기준으로 cnt++ 끼워 넣어라
//           StringBuilder sb = new StringBuilder(fileName);
//           changeFileNmae = sb.insert(insertPoint,cnt++).toString();
//           //중복이 되지않은 파일명이 나오면 리턴
//           if (!isThere(changeFileNmae)) {
//               return changeFileNmae;
//               //리턴되는 string 은 중복이 되지않는 파일명이 된다
//           }
//       }
//   }

    //파일 삭제하는 메서드
    public static void deleteFile(String fileName){
        //String 을 file로 변환 후 삭제
        convertFile(fileName).delete();
    }

    //파일명을 String 으로 받아서 중복되지 않으면
    //파일명을 그대로, 중복이 되며 처리해서 리턴
    //컨트롤러에서 처음 호출해야하는 부분
    public static String checkDuplicate(String fileName){
        System.out.println("checkDuplicate()");
        //만약 저장하려는 파일명이 폴더에 존재하지 않으면
        //파일명 그대로 리턴
        if (!isThere(fileName))
            return fileName;
        //파일이 존재하면 처리 : 메서드 호출
        return duplicateProcess(fileName);
    }





}

