<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="DiskInventoryFront._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>Welcome to the Disk Inventory Application!</h1>
        <p class="lead">This application is used to view information about the disks and manage the borrowing of inventory.</p>
        <br />
        
        <div class ="container" >
            <h4>Here is a list of all available disks!</h4>
           
     <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" HorizontalAlign="Center" CssClass="text-left">
            <Columns>
                <asp:BoundField AccessibleHeaderText="Disk" DataField="disk_name" HeaderText="Disk" SortExpression="disk_name" />
                <asp:BoundField AccessibleHeaderText="Artist First" DataField="artist_first" HeaderText="Artist First" SortExpression="artist_first" />
                <asp:BoundField AccessibleHeaderText="Artist Last" DataField="artist_last" HeaderText="Artist Last" SortExpression="artist_last" />
            </Columns>
        </asp:GridView>
                
            </div>
        <p>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:disk_inventoryBHConnectionString %>" SelectCommand="select disk_name,artist_first, artist_last  from disk_info
            left join cd_artist on cd_artist.disk_id = disk_info.disk_id
            left join artist on artist.artist_id = cd_artist.artist_id
            where disk_info.disk_status = 2;
            "></asp:SqlDataSource>
        </p>
    </div>


</asp:Content>
