import cpp
// 定义一个正则表达式，用来匹配域名或者IP地址
// 例如： https://www.baiducin.con     www.example.com, 192.168.0.1, [2001:db8::1]
string domainOrIpRegex() {
   result = "(^(?:\\d{1,3}\\.){3}\\d{1,3})" or 
   result = "^https?://.*?" or 
   result = "^[a-zA-Z0-9_\\.]+\\.[a-z]{2,10}" 
}

// 定义一个查询，用来查找代码中的函数调用，其参数是一个字符串字面量，其值可能是一个域名或者IP地址
from FunctionCall fc, StringLiteral sl,string loc1
where fc.getAnArgument() = sl 
      and  sl.getValue().regexpMatch(domainOrIpRegex())  
      and sl.isConstant()
      and loc1 = sl.getLocation().getFile().getAbsolutePath() +"$$" + sl.getLocation().getStartLine()+ " 代码中出现了域名或者IP,请手工检查是否可能存在后门：" + sl.getValue().toString() 

select loc1
// select var.getAnAssignedValue()  
