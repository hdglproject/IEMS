﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CrnEnable.aspx.cs" Inherits="Plugins_JHWMS_CrnManager_CrnEnable" %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>堆垛机查询与维护</title>
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/ext-chinese-font.css" />
    <link rel="Stylesheet" type="text/css" href="<%= Page.ResolveUrl("~/") %>resources/css/main.css" />
    <script type="text/javascript">
        var thisDirUrl = "<%= Page.ResolveUrl("./") %>";
        var thisRootUrl = "<%= Page.ResolveUrl("~/") %>";
    </script>
    <script type="text/javascript" src="<%= Page.ResolveUrl("~/") %>resources/js/jquery-1.7.1.js"></script>
    <!--gridMain数据展示-->
    <script type="text/javascript">
        //列表刷新数据重载方法
        var gridMainFresh = function () {
            var store = App.gridMain.getStore();
            store.currentPage = 1;
            store.pageSize = 100;
            App.gridMainPagingToolbar.doRefresh();
            return false;
        }
    </script>
    <script type="text/javascript">
        var commandcolumn_click = function (command, record) {
            if (command.toLowerCase() == "inputenable".toLowerCase()) {
                changeCrnInputEnable(record);
            }
            if (command.toLowerCase() == "outputenable".toLowerCase()) {
                changeCrnOutputEnable(record);
            }
            if (command.toLowerCase() == "disenable".toLowerCase()) {
                setCrnDisEnable(record);
            }
        }
    </script>
    <!--设置堆垛机状态-->
    <script type="text/javascript">
        //列表刷新数据重载方法
        var changeCrnInputEnable = function (record) {
            if (!record) {
                Ext.Msg.alert("提示", "请选择需要修改的堆垛机");
                return;
            }
            var msg = "确定将堆垛机【" + record.data.CRN_NO + "】" + "设置为【"
            if (record.data.CRN_IN_ENABLE == 1) {
                msg = msg + "入库禁用";
            }
            else {
                msg = msg + "入库可用";
            }
            msg = msg + "】？";
            Ext.Msg.confirm("提示", msg, function (btn) {
                if (btn == "yes") {
                    var crnNo = record.data.CRN_NO;
                    var enable = record.data.CRN_IN_ENABLE;
                    App.direct.ChangeCrnInputEnable(crnNo, enable, {
                        success: function (result) {
                            if (result == "") {
                                gridMainFresh();
                                Ext.Msg.alert('成功', "数据保存成功！");
                            } else {
                                Ext.Msg.alert("失败", result);
                            }
                        },
                        failure: function (errorMsg) {
                            Ext.Msg.alert("错误", errorMsg);
                        }
                    });
                }
            });
            return false;
        }
    </script>
    <script type="text/javascript">
        var changeCrnOutputEnable = function (record) {
            if (!record) {
                Ext.Msg.alert("提示", "请选择需要修改的堆垛机");
                return;
            }
            var msg = "确定将堆垛机【" + record.data.CRN_NO + "】" + "设置为【"
            if (record.data.CRN_IN_ENABLE == 1) {
                msg = msg + "出库禁用";
            }
            else {
                msg = msg + "出库可用";
            }
            msg = msg + "】？";
            Ext.Msg.confirm("提示", msg, function (btn) { 
                if (btn == "yes") {
                    var crnNo = record.data.CRN_NO;
                    var enable = record.data.CRN_OUT_ENABLE;
                    App.direct.ChangeCrnOutputEnable(crnNo, enable, {
                        success: function (result) {
                            if (result == "") {
                                gridMainFresh();
                                Ext.Msg.alert('成功', "数据保存成功！");
                            } else {
                                Ext.Msg.alert("失败", result);
                            }
                        },
                        failure: function (errorMsg) {
                            Ext.Msg.alert("错误", errorMsg);
                        }
                    });
                }
            });
            return false;
        }
    </script>
    <script type="text/javascript">
        var setCrnDisEnable = function (record) {
            if (!record) {
                Ext.Msg.alert("提示", "请选择需要修改的堆垛机叉");
                return;
            }
            var msg = "确定将堆垛机叉【" + record.data.CRN_FORK_NO + "】" + "设置为【"
            if (record.data.CRN_FORK_ENABLE == 1) {
                msg = msg + "禁用";
            }
            else {
                msg = msg + "可用";
            }
            msg = msg + "】？";
            Ext.Msg.confirm("提示", msg, function (btn) {
                if (btn == "yes") {
                    var crnForkNo = record.data.CRN_FORK_NO;
                    var enable = record.data.CRN_FORK_ENABLE;
                    App.direct.SetCrnDisEnable(crnForkNo, enable, {
                        success: function (result) {
                            if (result == "") {
                                gridMainFresh();
                                Ext.Msg.alert('成功', "数据保存成功！");
                            } else {
                                Ext.Msg.alert("失败", result);
                            }
                        },
                        failure: function (errorMsg) {
                            Ext.Msg.alert("错误", errorMsg);
                        }
                    });
                }
            });
            return false;
        }
    </script>
    <script type="text/javascript">
        //历史查询根据DeleteFlag的值进行样式绑定
        var SetRowClass = function (record, rowIndex, rowParams, store) {
            if ((record.get("CRN_IN_ENABLE") == "0") || (record.get("CRN_OUT_ENABLE") == "0")) {
                return "x-grid-row-deleted";
            }
        }
        var template = '<span style="background:{0};width:70px;display:block;text-align:center;">{1}</span>';
        var pctChange = function (value) {
            return Ext.String.format(template, (value == "可用") ? "green" : "red", value);
        };
    </script>

    <script type="text/javascript">
        var showAddWindows = function (record) {
            App.txtSrnName.setValue("");
            App.txtSrmNo.setValue("");
            App.txtMinCol.setValue("");
            App.txtMaxCol.setValue("");
            App.winAdd.show();
            return false;
        }
     </script>
</head>
<body>
    <form id="form1" runat="server">
        <ext:ResourceManager runat="server" />
        <ext:Viewport ID="viewport" runat="server" Layout="border">
            <Items>
                 <ext:Panel runat="server" Region="North" AutoHeight="true">
                   <TopBar>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:ToolbarSeparator />
                                <ext:Button runat="server" Icon="Find" Text="查询" ID="Button2">
                                    <Listeners>
                                        <Click Handler="gridMainFresh();" />
                                    </Listeners>
                                </ext:Button>
                                <ext:ToolbarSeparator />
                                <ext:ToolbarFill />
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                </ext:Panel>
                <ext:GridPanel ID="gridMain" runat="server" Region="Center">
                    <Store>
                        <ext:Store runat="server" PageSize="15">
                            <Proxy>
                                <ext:PageProxy DirectFn="App.direct.GridPanelBindData" />
                            </Proxy>
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="CRN_FORK_NO" />
                                        <ext:ModelField Name="CRN_NO" />
                                        <ext:ModelField Name="CRN_NAME" />
                                        <ext:ModelField Name="CRN_FORK_COUNT" />
                                        <ext:ModelField Name="MAX_OUT_TASK_COUNT" />
                                        <ext:ModelField Name="MAX_IN_TASK_COUNT" />
                                        <ext:ModelField Name="MAX_INPUT_OUTTIME" />
                                        <ext:ModelField Name="CRN_STATUS" />
                                        <ext:ModelField Name="CRN_IN_ENABLE" />
                                        <ext:ModelField Name="CRN_OUT_ENABLE" />
                                        <ext:ModelField Name="LIMIT_TASK_SIZE" />
                                        <ext:ModelField Name="CRN_IN_ENABLE_DESC" />
                                        <ext:ModelField Name="CRN_OUT_ENABLE_DESC" />
                                        <ext:ModelField Name="CRN_FORK_ENABLE" />
                                        <ext:ModelField Name="CRN_FORK_ENABLE_DESC" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <ColumnModel runat="server">
                        <Columns>
                            <ext:RowNumbererColumn Width="35" runat="server" />
                            <ext:Column runat="server" DataIndex="CRN_FORK_NO"      Text="堆垛机叉号"    Width="100" />
                            <ext:Column runat="server" DataIndex="CRN_NO"           Text="堆垛机编号"    Width="100" />
                            <ext:Column runat="server" DataIndex="CRN_NAME"         Text="堆垛机名称"    Width="100" />
                            <ext:Column runat="server" DataIndex="CRN_FORK_ENABLE"  Text="叉状态位"        Width="80"/>
                            <ext:Column runat="server" DataIndex="CRN_IN_ENABLE"    Text="入库状态位"      Width="80"/>
                            <ext:Column runat="server" DataIndex="CRN_OUT_ENABLE"   Text="出库状态位"      Width="80" />
                            <ext:Column runat="server" DataIndex="CRN_IN_ENABLE_DESC" Text="入库禁用"    Width="80" >
                                <Renderer Fn="pctChange" />
                            </ext:Column>
                            <ext:Column runat="server" DataIndex="CRN_OUT_ENABLE_DESC" Text="出库禁用" Width="80" >
                                <Renderer Fn="pctChange" />
                            </ext:Column>
                            <ext:Column runat="server" DataIndex="CRN_FORK_ENABLE_DESC" Text="叉禁用"    Width="80" >
                                <Renderer Fn="pctChange" />
                            </ext:Column>
                            <ext:CommandColumn runat="server" Width="320" Text="操作" Align="Center">
                                <Commands>
                                    <ext:GridCommand Icon="LockKey" CommandName="InputEnable" Text="改变入库状态">
                                        <ToolTip Text="禁用/启用堆垛机入库功能" />
                                    </ext:GridCommand>
                                    <ext:CommandSeparator />
                                    <ext:GridCommand Icon="LockKey" CommandName="OutputEnable" Text="改变出库状态">
                                        <ToolTip Text="禁用/启用堆垛机出库功能" />
                                    </ext:GridCommand>
                                    <ext:GridCommand Icon="LockKey" CommandName="DisEnable" Text="改变叉状态">
                                        <ToolTip Text="禁用/启用堆垛机叉" />
                                    </ext:GridCommand>
                                </Commands>
                                <Listeners>
                                    <Command Handler="return commandcolumn_click(command, record);" />
                                </Listeners>
                            </ext:CommandColumn>
                            
                        </Columns>
                    </ColumnModel>
                    <BottomBar>
                        <ext:PagingToolbar ID="gridMainPagingToolbar" runat="server">
                            <Plugins>
                                <ext:ProgressBarPager runat="server" />
                            </Plugins>
                        </ext:PagingToolbar>
                    </BottomBar>
                    <View>
                        <ext:GridView runat="server" StripeRows="true" TrackOver="true" />
                    </View>
                </ext:GridPanel>
            </Items>
        </ext:Viewport>
    </form>
</body>
</html>
