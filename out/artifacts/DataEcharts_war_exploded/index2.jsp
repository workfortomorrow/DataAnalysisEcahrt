<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" import="com.du.ConnDb,java.util.*" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
ArrayList<String[]> list = ConnDb.index_2();
%>    

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ECharts 可视化分析淘宝双11</title>
<link href="./css/style.css" type='text/css' rel="stylesheet"/>
<script src="./js/echarts.min.js"></script>
</head>
<body>
	<div class='header'>
        <p>ECharts 可视化分析淘宝双11</p>
    </div>
    <div class="content">
        <div class="nav">
            <ul>
                <li><a href="../index.jsp">所有买家各消费行为对比</a></li>
                <li><a href="./index1.jsp">男女买家交易对比</a></li>
                <li class="current"><a href="#">男女买家各个年龄段交易对比</a></li>
                <li><a href="index3.jsp">商品类别交易额对比</a></li>
                <li><a href="index4.jsp">各省份的总成交量对比</a></li>
            </ul>
        </div>
        <div class="container">
            <div class="title">男女买家各个年龄段交易对比</div>
            <div class="show" style="width: 100%;height: 1000px">
                <div class='chart-type'>散点图</div>
                <div id="main" style="width: 600px;height: 500px"></div>
            </div>
        </div>
    </div>
<script>
//基于准备好的dom，初始化echarts实例
console.log("this is ",document);
console.log("this is ",document.getElementById('main'));
console.log("this is ",echarts);
var myChart = echarts.init(document.getElementById('main'));

console.log("this is ",myChart);
// console.log("this is ",ConnDb.index_3());
// 指定图表的配置项和数据
var data = [];
data[0] = [];
data[1] = [];
<%
	for(String[] a:list){
		if(a[0].equals("0")){
			%>
			data[0].push([<%=a[0]%>,<%=a[1]%>,<%=a[2]%>]);
			<%
		}else if(a[0].equals("1")){
			%>
			data[1].push([<%=a[0]%>,<%=a[1]%>,<%=a[2]%>]);
			<%
		}
	}
%>
console.log("this is data",data[0],data[1]);
option = {
    backgroundColor: new echarts.graphic.RadialGradient(0.3, 0.3, 0.8, [{
        offset: 0,
        color: '#f7f8fa'
    }, {
        offset: 1,
        color: '#cdd0d5'
    }]),
    title: {
        text: '男女买家各个年龄段交易对比'
    },
    legend: {
        right: 10,
        data: ['women', 'men']
    },
    xAxis: {
        splitLine: {
            lineStyle: {
                type: 'dashed'
            }
        }
    },
    yAxis: {
        splitLine: {
            lineStyle: {
                type: 'dashed'
            }
        },
        scale: true
    },
    series: [{
        name: 'women',
        data: data[0],
        type: 'scatter',
        symbolSize: function (data) {
            return Math.sqrt(data[2]) / 5e2;
        },
        label: {
            emphasis: {
                show: true,
                formatter: function (param) {
                    return param.data[3];
                },
                position: 'top'
            }
        },
        itemStyle: {
            normal: {
                shadowBlur: 10,
                shadowColor: 'rgba(120, 36, 50, 0.5)',
                shadowOffsetY: 5,
                color: new echarts.graphic.RadialGradient(0.4, 0.3, 1, [{
                    offset: 0,
                    color: 'rgb(251, 118, 123)'
                }, {
                    offset: 1,
                    color: 'rgb(204, 46, 72)'
                }])
            }
        }
    }, {
        name: 'men',
        data: data[1],
        type: 'scatter',
        symbolSize: function (data) {
            return Math.sqrt(data[2]) / 5e2;
        },
        label: {
            emphasis: {
                show: true,
                formatter: function (param) {
                    return param.data[3];
                },
                position: 'top'
            }
        },
        itemStyle: {
            normal: {
                shadowBlur: 10,
                shadowColor: 'rgba(25, 100, 150, 0.5)',
                shadowOffsetY: 5,
                color: new echarts.graphic.RadialGradient(0.4, 0.3, 1, [{
                    offset: 0,
                    color: 'rgb(129, 227, 238)'
                }, {
                    offset: 1,
                    color: 'rgb(25, 183, 207)'
                }])
            }
        }
    }]
};

// 使用刚指定的配置项和数据显示图表。
myChart.setOption(option);
console.info(option.series[0].data);
console.info(option.series[1].data);
</script>
</body>
</html>