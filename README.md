# StataDeepSeek
本命令是对stata的chatgpt命令的简单修改，以使用deepseek api端口，供科研使用。原命令作者为Chuntao Li, Ph.D. , China Stata Club(爬虫俱乐部)(chtl@henu.edu.cn)和Xueren Zhang, China Stata Club(爬虫俱乐部)(snowmanzhang@whu.edu.cn)，如有侵权，请联系施一信(2002060224@pop.zjgsu.edu.cn)删除。

之后会考虑加上其他LLM API的支持，然后commit到原命令里。由于我不会写Stata代码，现在暂时先这样。

## 安装
可以通过下载`code/deepseek.ado`到本地`adopath`安装，也可以指定新路径使Stata识别命令
```stata
adopath + "../code"
```
## 使用
申请[DeepSeek API](https://platform.deepseek.com)，参考`code/demo.ipynb`及`chatgpt`命令的帮助文件使用。

在Jupyter中使用Stata可以参考[nbstata](https://hugetim.github.io/nbstata/)。

## Reference
[李春涛. 2024. *GPT在文本分析中的应用：一个基于Stata的集成命令用法介绍*](zotero://select/items/1_KI4E9T7E)
