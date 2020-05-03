# robotframework_training
**项目说明：**《自动化测试实战宝典：Robot Framework + Python 从小工到专家》书中源码示例



为了方便读者在学习实践 **《自动化测试实战宝典：Robot Framework + Python 从小工到专家》** 书中内容时，可以更佳有效的对照源码示例学习参考。现将书中涉及到的关键源码示例公布出来。


> **特别说明**：书中源码示例提供的作用并不建议大家拿来直接用，读者在实操过程中，建议还是要自己动手敲一遍，按照书中的参考步骤，如果在调试过程，无法得到正确的预期，先思考自行排查解决，仍然解决不了的话，再去从源码中进行分析差异，这样对大家学习成长才能更佳有效。

## 1. 源码示例目录
![](https://img2020.cnblogs.com/blog/541408/202005/541408-20200503105131116-2045732819.png)

PS: 前四章侧重行业分析、测试思维、编程基础的学习，书中示例源码从第5章开始。

### 1.1 第5、6章示例
![](https://img2020.cnblogs.com/blog/541408/202005/541408-20200503105813566-1978899191.png)

PS: 第5、6章示例较为简单，不过多说明，读者可以根据书中内容对照示例名称查找即可。

### 1.2 第7章示例
第7章涉及到源码的示例，共分为三类：
- 第一类为书中7.5章节提到的《接口测试项目设计规范》所涉及到的项目结构
- 第二类为书中7.6~7.9章节中《接口项目实战》所涉及到的源码及项目结构
- 第三类为书中7.10章节中 《开发系统关键字》所涉及到的源码

#### 第一类：接口测试项目整体分层结构
![](https://img2020.cnblogs.com/blog/541408/202005/541408-20200503110629261-739838528.png)



#### 第二类：接口测试项目最佳实战
![](https://img2020.cnblogs.com/blog/541408/202005/541408-20200503111251967-666303714.png)

这部分提供的示例源码中，**为了安全隐私考虑，已将项目示例中涉及到的真实URL和用户名、密码去掉**。（读者拿到源码是无法直接在本地运行成功的，更多是让大家借鉴整体设计思路。）

#### 第三类：自定义系统关键字
![](https://img2020.cnblogs.com/blog/541408/202005/541408-20200503113301364-412605111.png)
这部分，读者认真理解书中的每一个步骤，对照开放的源码示例，基本上应该是没有太大问题。


### 1.3 第8章示例
![](https://img2020.cnblogs.com/blog/541408/202005/541408-20200503113842653-629180114.png)
本章示例，更多是为了展示如何对UI Web自动化进行分层设计，提供的示例源码中已将真实的用户名、密码脱敏处理过了。

### 1.4 第9章示例

在第9章示例目录中，内容共分为三部分：

![](https://img2020.cnblogs.com/blog/541408/202005/541408-20200503115248835-1326783017.png)

- 一部分为Robot Framework项目实战所涉及到App自动化完整实战示例结构
![](https://img2020.cnblogs.com/blog/541408/202005/541408-20200503114453279-502528286.png)

包括了：Android端、iOS端、微信小程序、模拟器、真机等，读者在参照第9章源码示例时，可按照书中提供的名称进行对应查找相应端的示例即可。

- 一个是apk目录为：书中9.4.3小节中提到的获取App包名和Activity名的应用安装包。
- 一个是python_example目录为：第9章中，涉及到用Python演示的App自动化示例集合。


> 需要注意的是，在第9中的源码示例中同样去掉了真实调度的用户名、密码。


### 1.5 第10章示例

第10章侧重对Robot Framework开源框架主体结构的解析过程，更多的是Robot Framework项目本身的源码，[官方项目源码](https://github.com/robotframework/robotframework)，书中所涉到的示例，主要是在10.3章节中，重写了`--listener`方法，创建了一个`RobotListener.py`监听类文件，源码示例如下：

```python
class RobotListener(object):
    ROBOT_LISTENER_API_VERSION = 2

    def start_suite(self, name, args):
        print("Starting Suite : " + name + "  " + args['source'])

    def start_test(self, name, args):
        print("Starting test : " + name)
        if args['template']:
            print('Template is : ' + args['template'])

    def end_test(self, name, args):
        print("Ending test:  " + args['longname'])
        print("Test Result is : " + args['status'])
        print("Test Time is: " + str(args['elapsedtime'])）)

    def log_message(self, message):
        print(message['timestamp'] + " :   " + message['level'] + " : " + message['message'])

```


### 2. 最后

下面是我的公众号二维码图片，欢迎关注，如有疑问，请公号后台回复: 「me」 ，添加作者微信进行交流。

![扫码关注:「测试开发技术」](https://testerhome.com/uploads/photo/2019/bc807b98-f665-49b6-a731-79c7720a66aa.jpg!large) 

>关注微信公众号：**[测试开发技术](#jump_10)**
，了解更多软件测试开发领域开源技术、自动化、性能、CI/CD、职场经验等知识。


### 3. 新书推荐

<img src="https://testerhome.com/uploads/photo/2020/a549e855-54e7-4437-a56f-76cfbbfc6b5b.png!large" width = "250" height = "320" div align=center />




![扫码订购:「自动化测试实战宝典：从小工到专家」](https://img2020.cnblogs.com/blog/541408/202005/541408-20200503130833480-1604490522.png) 

或可点击 [传送门：京东商城](https://item.jd.com/12629017.html#)  和 [传送门：当当网](http://product.dangdang.com/28520424.html) 直达新书网上订购页面。
