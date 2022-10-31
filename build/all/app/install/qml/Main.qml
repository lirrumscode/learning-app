import QtQuick 2.7
import Ubuntu.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'learningapp.lirrums'
    automaticOrientation: false
    visible: true
    width: units.gu(70)
    height: units.gu(75)

    function getPosts(response)
    {
        mdlgrid.model=response
    }

    function onComponentStarted()
    {

        const xhr=new XMLHttpRequest()
        const method="GET";
        const url="https://lirrumscode.ml/wp-json/wp/v2/posts/";
        xhr.open(method, url, true);
        xhr.onreadystatechange=function(){
        if (xhr.readyState===XMLHttpRequest.DONE)
        {
            var status=xhr.status;
            if (status===0 || (status>=200 && status<400))
            {
                getPosts(JSON.parse(xhr.responseText))
            }else{
            console.log("There has been an error with the request", status, JSON.stringify(xhr.responseText))
        }
    }
}
xhr.send();
}

Page {
    anchors.fill: parent

    header: PageHeader {
        width: units.gu(70)
        height: units.gu(7)
        Item{
            Column{
                padding: 5.0
                spacing: 2
                Text{
                    text: 'Learning Technology'
                    color:"#042b48"
                    font { family: 'Terminal Regular'; pixelSize: 18; italic: false; bold: true;}
                }

                Text{
                    text: 'Select your favorite category and start studying!'
                    color:"#042b48"
                    font { family: 'Terminal Regular'; pixelSize: 14; }
                }
            }

        }
    }


    Column{
        anchors.fill: parent
        topPadding: 50
        leftPadding: 5
        rightPadding: 5
        spacing: 2
        ListView {
            id:mdlgrid
            width: parent.width
            height: parent.height
            spacing: 5
            delegate: Rectangle{ id: rect; width: units.gu(100);height: 150; color:'#042b48'; radius: 5.5

            Row{
                Column{
                    padding:10
                    Image {
                        width: 120; height: 120
                        fillMode: Image.TileHorizontally
                        verticalAlignment: Image.AlignLeft
                        id: photoImage
                        source: modelData.yoast_head_json.og_image[0].url
                    }

                }
                Column{
                    padding:10
                    Text{
                        text:modelData.title.id
                        color: "#fff"
                    }
                    Text{
                        text:modelData.yoast_head_json.title
                        color: "#fff"
                        wrapMode: Text.WordWrap
                        width: rect.width
                        font.bold: true
                        font.pixelSize: 20
                        padding: 5.0
                    }
                    Text{
                        text:modelData.yoast_head_json.og_description
                        color: "#fff"
                        wrapMode: Text.WordWrap
                        width: rect.width
                        font.bold: false
                        font.pixelSize: 14
                        padding: 5.0
                    }
                    Button{
                        text: "<b>Go to the</b> <i>url!</i>"
                        width: units.gu(30);height: 40;
                        onClicked: { Qt.openUrlExternally(modelData.yoast_head_json.og_url); }
                    }
                }
            }

        }
    }
}
}
Component.onCompleted: {onComponentStarted()}
}
