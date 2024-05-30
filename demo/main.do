cd "/Users/cyberbacchus/Github/GPT在文本分析中的应用_一个基于Stata的集成命令用法介绍_附加材料"

*************************基础配置******************************
*******请在运行示例代码前首先运行本部分代码，以获取相应文件***********

clear all
global OPENAI_API_KEY = fileread("/Users/cyberbacchus/Keys/DeepSeekAPI.txt")
local base "https://stata-chatgpt.oss-cn-beijing.aliyuncs.com/chatgpt"
webuse set "`base'"

forvalue i = 1/5{
	copy "`base'/prompt`i'.txt" "prompt`i'.txt",replace
}

forvalue i = 1/4{
	copy "`base'/content`i'.txt" "content`i'.txt",replace
}

******特别说明：如果您无法正常使用chatgpt命令服务*************
****************可能需要在命令选项中配置proxy()选项***********
****************详情请通过help chatgpt查询********************


*****附录B：chatgpt命令辅助泛技术类工作专门示例*****

//case B.1 命令查询
//案例主旨：在只知道功能的情况下，查询相应的Stata命令
clear all
sysuse auto,clear
chatgpt talk, openai_api_key($OPENAI_API_KEY) command("如何查询变量mpg的20%分位数") stata 

//case B.2 代码生成
//案例主旨：在只知道效果的情况下，查询相应的Stata命令
clear all
webuse data1,clear
chatgpt read data,openai_api_key($OPENAI_API_KEY) stata ///
	command("观察数据详情，请指出如何通过stkcd和year生成delta") ///
	do("list")

	
//case B.3 命令速览
//案例主旨：在对新命令一无所知的情况下，查询使用方法
clear all
ssc install cntraveltime,replace //该命令为外部命令，需要通过SSC下载安装
chatgpt read cntraveltime.sthlp , openai_api_key($OPENAI_API_KEY) stata ///
	command("该命令能否计算远洋轮船的行程距离？")


//case B.4 报错答疑
//案例主旨：在程序遇到错误时，令GPT根据现有信息判断问题
clear all
sysuse auto,clear
reg mpg prlce   //此时发生报错
chatgpt read data,openai_api_key($OPENAI_API_KEY) stata ///
	command("我输入reg mpg prlce报错：variable prlce not found，怎么改") do("sum *")

//case B.5 实证答疑
clear all
chatgpt talk, openai_api_key($OPENAI_API_KEY) command("回归时以变量 prov 作为聚类变量来计算聚类稳健的标准误。") stata 


*****附录C：chatgpt命令辅助文本工作专门示例*****

//case C.1 翻译
clear all
chatgpt read other, openai_api_key($OPENAI_API_KEY) systemprompt("你是一名精通中文与英文的翻译，请将以下中文摘要翻译为符合学术风格与规范的英文。")  file("content1.txt")

//case C.2 润色
clear all
chatgpt read other, openai_api_key($OPENAI_API_KEY) systemprompt("你是一名精通中文与英文的翻译，请阅读以下中文摘要及两段对应的英文翻译，尽可能详细举例判断哪份翻译质量更好，更符合学术风格和规范，使用中文回答")  file("content2.txt")



*****附录D：使用chatgpt命令进行数据清洗*****

//case D.1 数据清洗1
clear all
chatgpt read other, openai_api_key($OPENAI_API_KEY) command("以csv格式报告中国四个省份的人口，人口单位统一为万人，中文回复")  file("content3.txt")

//case D.2 数据清洗2
clear all
webuse data2.dta, clear

gen GPT_alalysis = ""
local prompt = fileread("prompt1.txt")

timer clear 1
timer on 1
forvalue i = 1/`=_N'{
	chatgpt talk, openai_api_key($OPENAI_API_KEY) command(`"`=content[`i']'"') systemprompt("`prompt'") 
	replace GPT_alalysis = fileread("output.txt") in `i'
}
timer off 1
timer list 1


*****附录E：使用chatgpt命令进行训练集标注*****

clear all
webuse data3.dta, clear

gen GPT_alalysis = ""
local prompt = fileread("prompt2.txt")

timer clear 2
timer on 2
forvalue i = 1/`=_N'{
	chatgpt talk, openai_api_key($OPENAI_API_KEY) systemprompt("`prompt'")  command(`"`=content[`i']'"')
	replace GPT_alalysis = fileread("output.txt") in `i'
}
timer off 2
timer list 2


***** 附录F：使用chatgpt命令进行文本语调判断 *****


clear all
webuse data4.dta,clear
gen tone = ""
local prompt = fileread("prompt3.txt")


timer clear 3
timer on 3
forvalue i = 1/`=_N'{
	chatgpt talk, openai_api_key($OPENAI_API_KEY) command(`"`=ori_text[`i']'"') systemprompt(`"`prompt'"') 
	replace tone = fileread("output.txt") in `i'
}
timer off 3
timer list 3



***** 附录G：使用chatgpt命令进行主题分类 *****

clear all
webuse data5.dta,clear
gen class = ""
local prompt = fileread("prompt4.txt")


timer clear 4
timer on 4
forvalue i = 1/`=_N'{
	chatgpt talk, openai_api_key($OPENAI_API_KEY) command(`"`=resume[`i']'"') systemprompt(`"`prompt'"') 
	replace class = fileread("output.txt") in `i'
}
timer off 4
timer list 4


***** 附录H：使用chatgpt命令进行精准分词 *****

clear all
local prompt = fileread("prompt5.txt")
chatgpt read other, openai_api_key($OPENAI_API_KEY) systemprompt(`"`prompt'"')  file("content4.txt")


