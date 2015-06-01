$(function (categories, series_name, series_data) {
    $('#graph').highcharts({
        chart: {
            type: 'line'
        },
        title: {
            text: 'Team Performance'
        },
        subtitle: {
            text: ''
        },
        xAxis: {
            categories: categories
        },
        yAxis: {
            title: {
                text: 'Points earned'
            }
        },
        plotOptions: {
            line: {
                dataLabels: {
                    enabled: true
                },
                enableMouseTracking: false
            }
        },
        series: [{
            name: series_name,
            data: series_data
        }]
    });
});
