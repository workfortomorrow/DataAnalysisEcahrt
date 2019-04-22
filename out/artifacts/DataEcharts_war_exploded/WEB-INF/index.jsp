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
  <div id="container" style="height: 100%"></div>

  <script type="text/javascript">
      var dom = document.getElementById("container");
      var myChart = echarts.init(dom);
      var app = {};
      option = null;
      myChart.showLoading();
      $.get('data/les-miserables.gexf', function (xml) {
          myChart.hideLoading();

          var graph = echarts.dataTool.gexf.parse(xml);
          var categories = [];
          for (var i = 0; i < 9; i++) {
              categories[i] = {
                  name: '系列' + i
              };
          }
          graph.nodes.forEach(function (node) {
              node.itemStyle = null;
              node.value = node.symbolSize;
              node.label = {
                  normal: {
                      show: node.symbolSize > 30
                  }
              };
              node.category = node.attributes.modularity_class;
          });
          option = {
              title: {
                  text: 'Les Miserables',
                  subtext: 'Default layout',
                  top: 'bottom',
                  left: 'right'
              },
              tooltip: {},
              legend: [{
                  // selectedMode: 'single',
                  data: categories.map(function (a) {
                      return a.name;
                  })
              }],
              animationDuration: 1500,
              animationEasingUpdate: 'quinticInOut',
              series : [
                  {
                      name: 'Les Miserables',
                      type: 'graph',
                      layout: 'none',
                      data: graph.nodes,
                      links: graph.links,
                      categories: categories,
                      roam: true,
                      focusNodeAdjacency: true,
                      label: {
                          normal: {
                              position: 'right',
                              formatter: '{b}'
                          }
                      },
                      itemStyle: {
                          normal: {
                              borderColor: '#fff',
                              borderWidth: 1,
                              shadowBlur: 10,
                              shadowColor: 'rgba(0, 0, 0, 0.3)'
                          }
                      },
                      lineStyle: {
                          normal: {
                              curveness: 0.3
                          }
                      },
                      emphasis: {
                          lineStyle: {
                              width: 10
                          }
                      }
                  }
              ]
          };

          myChart.setOption(option);
      }, 'xml');;
      if (option && typeof option === "object") {
          var startTime = +new Date();
          myChart.setOption(option, true);
          var endTime = +new Date();
          var updateTime = endTime - startTime;
          console.log("Time used:", updateTime);
      }
  </script>

  </body>
</html>
