<%--
  Created by IntelliJ IDEA.
  User: duhongjiang
  Date: 2018/2/17
  Time: 21:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
  <head>

    <meta charset="utf-8">
    <script type="text/javascript" src="./js/echarts.min.js"></script>
    <script type="text/javascript" src="./js/jquery-3.3.1.min.js"></script>
    <script type="text/javascript" src="./js/dataTool.min.js"></script>


  </head>
  <body >
  <div id="container" style="height:93%"></div>

  <div id = "div1"></div>
  <script type="text/javascript">
      var dom = document.getElementById("container");
      var myChart = echarts.init(dom);
      var app = {};
      option = null;
      myChart.showLoading();
      $.get('data/les-miserables1.gexf', function (xml) {
          myChart.hideLoading();

          var graph = echarts.dataTool.gexf.parse(xml);
          var categories = [];
          var categories2 = ['接入网关','接出网关','公共基础','序列工程','第三支柱','反向工程','公共批量','第三支柱批量','fg'];
          for (var i = 0; i < 9; i++) {
              categories[i] = {
                  name: '系列' + categories2[i]
              };
          }

          graph.nodes.forEach(function (node) {
              node.itemStyle = null;
              node.symbolSize = 8;
              node.value = node.symbolSize;
              node.label = {
                  normal: {
                      show: true
                  }
              };
              node.category = node.attributes.modularity_class;
              node.x = node.y = null;
              node.draggable = true;
          });

          option = {
              title: {
                  text: '个人互联网服务依赖关系',
                  subtext: 'Default layout',
                  top: 'bottom',
                  left: 'right'
              },

              legend: [{
                  // selectedMode: 'single',
                  data: categories.map(function (a) {
                      return a.name;
                  })
              }],
              animation: false,
              series : [
                  {
                      name: '个人互联网账户系统服务依赖关系',
                      type: 'graph',
                      layout: 'force',
                      data: graph.nodes,
                      links: graph.links,
                      categories: categories,
                      roam: true,



                      label: {
                          normal: {
                              position: 'left',
                              verticalAlign: 'middle',
                              align: 'right',
                              fontSize: 11

                          }
                      },
                      force: {
                          repulsion: 100
                      }
                  }
              ]
          };

          myChart.setOption(option);
      }, 'xml');;
      if (option && typeof option === "object") {
          var startTime = +new Date();
          myChart.setOption(option, true);
          myChart.on('click',{dataType: 'edge'},function (params) {
              console.log(params);
              window.location.replace("https://www.baidu.com");
          })
          var endTime = +new Date();
          var updateTime = endTime - startTime;
          console.log("Time used:", updateTime);
      }




      /**
       拼接路径
       */
      function appendPath(id){
          var str = id;
          var links = graph.links;
          var i = 0;
          var map = {};
          for( i = 0 ; i < links.length; i++){
              map[links[i].target] = links[i].source;
          }
          while(true){
              if(map[id] == undefined){
                  break;
              }
              str = map[id]  +"->" + str;
              id = map[id] ;
          }
          return str;
      }
  </script>

  </body>
</html>
