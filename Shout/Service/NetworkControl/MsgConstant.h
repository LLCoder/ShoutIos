//
//  MsgConstant.h
//  

#define RET_DOWNLOAD_ERRO_MSG	@"{\"content\":\"\",\"results\":{\"detail\":\"\",\"message\":\"File: '%@' is not exist!\",\"status\":\"404\"}}"

#define RET_XML_DOWNLOADSUCCESS_MSG	@"{\"content\":\"\",\"results\":{\"detail\":\"\",\"message\":\"File: '%@' Download Successfully!\",\"status\":\"200\"}}"

#define HTTP_TIMEOUT			10  // 默认超时时间10妙
#define HTTP_DOWNLOADTIMEOUT	20  // 下载超时时间20妙
#define HTTP_UPLOADTIMEOUT	    20  // 上传超时时间20妙


/*
 此类定义所有公共接口消息
 */

typedef enum tagRequestType
{
	RequestTypeMsg       = 1,
	RequestTypeUpload    = 2,
	RequestTypeDownload  = 3,
	RequestTypeUnknown   = -1,
}RequestType;

typedef enum CmdCode
{
	//system
	CC_VersionCheck             = 0x0001,
	CC_NetCheck					= 0x0002, // 网络检测
	
	//userInterface
	CC_Register 			  	= 0x0101,
    CC_Login			  	    = 0x0102,
    CC_OneSentence              = 0x0103,
    CC_WoundPaste               = 0x0104,
    CC_Message                  = 0x0105,
    CC_MsgClick                 = 0x0106,
    CC_SignIn                   = 0x0107,
    CC_AddDB                    = 0x0108,
    CC_Ranking                  = 0x0109,

    //download/upload files
	CC_DownloadFile             = 0x0301,
    CC_UploadFile               = 0x0302,
    
	CC_Unknown                  = -1,
}E_CMDCODE;

typedef enum HttpErr{
	E_HTTPSUCCEES = 0,
	E_HTTPERR_CANCEL,
	E_HTTPERR_TIMEOUT,
	E_HTTPERR_AUTH,
	E_HTTPERR_UNABLECREATE,
	E_HTTPERR_TOOMUTHREDIRECT,
	E_HTTPERR_NETCLOSE,
	E_HTTPERR_UNKONW = -1
}E_HTTPERR;
