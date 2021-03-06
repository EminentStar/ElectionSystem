<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="http://code.jquery.com/jquery-2.0.3.min.js"></script>
<!-- script src="http://code.jquery.com/jquery-1.9.1.min.js"></script-->
<script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
<script type="text/javascript" src="<spring:url value="/js/jquery/plugin/validation/jquery.validate.min.js" />"></script>
<script type="text/javascript" src="<spring:url value="/js/jquery/plugin/storage/jquery.storageapi.min.js" />"></script>
<script type="text/javascript">
   //$.sessionStorage.set('test',{a:'val'});
   var key = "message.properties";
   //ì ì´ì¨ì¼ë¡ ìë²ìì ë°ìì¤ê³  íë©´ ë ê±° ê°ìì!
   
   if($.sessionStorage.isEmpty(key)){//ë­ íëë§ë¤ì£ ?
      $.get('<spring:url value="/rsc/i18n" />',
            {},
            function(response){
               $.sessionStorage.set(key,response);   
            });
   }
   
   //ë¹¼ì ì°ë ë©ìë íë ë§ë¤ì´ë³´ì£ !
    /* function getMessage(code){
      var messages = $.sessionStorage.get(key);
      return eval("messages."+ code);//ê¼­ ì¸ìì¼íë ì¤í¬ë¦½í¸ í¨ì? eval?? 
   } */
    
   var validation = {
         //ìì getMessageë©ìëë¥¼ ì¬ê¸° ì§ì´ë£ì
          getMessage : function(code, args){ //code1ì íëëë°ì! ìë°ì¤í¬ë¦½í¸ë ë§¤ê°ë³ìì ìì¼ë©´ ê·¸ë¥ ìë¤ê³  ì·¨ê¸
             if(args == undefined){
            return eval("$.sessionStorage.get('"+key + "')."+code.replace(/[.]/g,"_"));
            //$.sesstionStorage.get(key).label_name; ì ê°ì ìë¯¸ë¤
             }else{
                /* console.log(code);
                console.log(args); */
                   var msg = this.getMessage(code);
                for(var i=0;i<args.length;i++){
                  msg = msg.replace("{" + i + "}", isNaN(args[i])?this.getMessage(args[i]) : args[i]);
                }
                return msg;
             }
         },
         showMessage : function(errors , labelPrefix){ //ì¬ê¸°ì ìë¬ë¥¼ ë°ì
            //console.log($(labelPrefix + "name").text().trim()+ "_trim");
            var parent = this; //each ë°ìì parentì ì¸í´ì£¼ê³  ì°ì!
            //alert(this.getMessage("label_name"));
            $(errors).each(function(index, error){
               //console.log(error);
               var args = error.arguments;
               var code = error.code;
               var field = error.field;
               var label = $(labelPrefix + field).text().trim();
               //var label = $("td#label_"+field).text(); //ì´ë°ê²ë¤ìhtmlíì´ì§ë§ë¤ ì¡°ê¸ì©íë ¤ì§ììê¸°ì íë¼ë¯¸í°ë¡ ë°ëê²ì¢ë¤
               label = label.length >0 ? label : labelPrefix;
               var msg = parent.getMessage(code + "_general");
               //ìë¬ ë§¤ê°ë³ìì ê°¯ìì ë§ê² {0} ë±ì ì¹ííì!               
               if(args.length == 3){
                  //lengthê°ìê²½ì°ë ëê°ë¥¼ ë°ê¶ì¼ëì£ ?
                  //lengthê°ìê²½ì° 3ê°ê°ë¤ì´ê°ëê¹ ì´ 3ê°ë¥¼ ë°ê¾¸ê² ë¤!
                     msg = msg.replace("{0}",label).replace("{1}",args[2])
                     .replace("{2}",args[1]);
               }else if(args.length == 2){
                     msg = msg.replace("{0}" , label).replace("{1}",args[1]);
               }
               else{
                  msg = msg.replace("{0}",label);
               }
               $("#"+field).focus();
               alert(msg);
               
               return false; //return falseë¤ì!
            });
         }
   };
   
   
   var vs = {
         config:{
            contextRoot : "<spring:url value="" />"
         },
         session : {//여기서 config.jsp에서 setAttribute한 userInfo를 쓸수있는것이다
            user: { 
               id : "${userInfo.username}",
               name: "${userInfo.users_name}",
               cellPhone : "${userInfo.cell_phone}",
               email : "${userInfo.email}",
               dept_code : "${userInfo.dept_code}",
               role : [<c:forEach var="val" items="${userInfo.role}">'<c:out value="${val}"/>' ,</c:forEach> ]
               //c íê·¸ ì°ê² ë¤ê³  ì ì¸ì í´ì¼í¨!
            }
         }
   }
   
   /*
   vs.config = {
      contextRoot: "#springUrl("/")",
      locale: "${locale}",
      country: "${locale.getCountry()}",
      language: "${language}"
   };
   vs.session.user = {
      id: "$!{userSession.detail.username}",
      name: "$!{userSession.detail.name}",
      //role: [#foreach($role in $userSession.detail.role)#if ($foreach.count > 1),#end"${role}"#end],
      mfCode: "$!{userSession.detail.mfCode}",
      mfName: "$!{userSession.detail.mfName}",
      dtCode: "$!{userSession.detail.dtCode}",
      dtName: "$!{userSession.detail.dtName}",
      workNo: "$!{userSession.detail.workNo}",
      ceoName: "$!{userSession.detail.ceoName}",
      address: "$!{userSession.detail.address}",
      tel: "$!{userSession.detail.tel}",
      fax: "$!{userSession.detail.fax}",
      email: "$!{userSession.detail.email}"   
   };   //ì£¼ìì²ë¦¬íê³  ì ì´ì¿¼ë¦¬ cdnë³µì¬í´ì ë¶ì¬ë£ì´ì£¼ì¸ì
   */
</script>
   