
<%@ page language="java" import="com.du.ConnDb,java.util.*" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%
  ArrayList<String[]> list = ConnDb.index_1();
%>

<%
  String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>


  <base href="<%=basePath%>">
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>ECharts 可视化分析淘宝双11</title>
  <script src="./js/echarts.min.js">


  </script>
</head>
<body>
<div class='header'>
  <p>ECharts 可视化分析淘宝双11</p>
</div>
<div class="content">
  <div class="nav">
    <ul>
      <li><a href="../index.jsp">所有买家各消费行为对比</a></li>
      <li class="current"><a href="#">男女买家交易对比</a></li>
      <li><a href="index2.jsp">男女买家各个年龄段交易对比</a></li>
      <li><a href="index3.jsp">商品类别交易额对比</a></li>
      <li><a href="index4.jsp">各省份的总成交量对比</a></li>
    </ul>
  </div>
  <div class="container">
    <div class="title">男女买家交易对比</div>
    <div class="show" style="width: 100%;height: 1000px">
      <div class='chart-type'>饼图</div>
      <div id="main" style="width: 2000px;height: 2000px"></div>
    </div>
  </div>

</div>
<script src="./js/echarts.min.js">
  //基于准备好的dom，初始化echarts实例
  console.log("this is ",document);
  console.log("this is ",document.getElementById('main'));
  console.log("this is ",echarts);
  var myChart = echarts.init(document.getElementById('main'));

  console.log("this is ",myChart);
  // console.log("this is ",ConnDb.index_3());
  // 指定图表的配置项和数据
  option = {
    backgroundColor: '#2c343c',

    title: {
      text: '男女买家交易对比',
      left: 'center',
      top: 20,
      textStyle: {
        color: '#ccc'
      }
    },

    tooltip : {
      trigger: 'item',
      formatter: "{a} <br/>{b} : {c} ({d}%)"
    },

    visualMap: {
      show: false,
      min: 80,
      max: 600,
      inRange: {
        colorLightness: [0, 1]
      }
    },
    series : [
      {
        name:'消费行为',
        type:'pie',
        radius : '55%',
        center: ['50%', '50%'],
        data:[
          {value:<%=list.get(0)[1]%>, name:'女性'},
          {value:<%=list.get(1)[1]%>, name:'男性'},
          {value:<%=list.get(2)[1]%>, name:'未知'},
        ].sort(function (a, b) { return a.value - b.value}),
        roseType: 'angle',
        label: {
          normal: {
            textStyle: {
              color: 'rgba(255, 255, 255, 0.3)'
            }
          }
        },
        labelLine: {
          normal: {
            lineStyle: {
              color: 'rgba(255, 255, 255, 0.3)'
            },
            smooth: 0.2,
            length: 10,
            length2: 20
          }
        },
        itemStyle: {
          normal: {
            color: '#c23531',
            shadowBlur: 200,
            shadowColor: 'rgba(0, 0, 0, 0.5)'
          }
        },

        animationType: 'scale',
        animationEasing: 'elasticOut',
        animationDelay: function (idx) {
          return Math.random() * 200;
        }
      }
    ]
  };

  // 使用刚指定的配置项和数据显示图表。
  myChart.setOption(option);
</script>
</body>
</html>