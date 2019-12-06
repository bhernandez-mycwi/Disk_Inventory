<%--/*************************************************************************************/
/*  Date	Name	Description                                                      */
/*  -----------------------------------------------------------------------------    */
/*                                                                                   */
/*  12/02/2019  Brian Hernandez   Initial deploy of Check Out Page  
    12/5/2019   Brian Hernandez   Added summary of who checked out what in a label using
                                    Session data                                    */
/*************************************************************************************/--%>
<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CheckOut.aspx.cs" Inherits="DiskInventoryFront.Maintenance.CheckOut" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <br />
    <div id ="Checkout">
        
        <h1>Check Out</h1>
        <asp:Label ID="lblSummary" runat="server"></asp:Label>
        
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="disk_id" DataSourceID="SqlDataSource1" OnSelectedIndexChanged = "OnSelectedIndexChanged">
        <Columns>
            <asp:BoundField DataField="disk_name" HeaderText="Disk Name" SortExpression="disk_name" >
            <HeaderStyle CssClass="text-center" HorizontalAlign="Center" VerticalAlign="Middle" />
            </asp:BoundField>
            <asp:BoundField DataField="artist_first" HeaderText="Artist First" SortExpression="artist_first" >
            <HeaderStyle CssClass="text-center" HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="artist_last" HeaderText="Artist Last" SortExpression="artist_last" >
            <HeaderStyle CssClass="text-center" HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="disk_id" HeaderText="Disk ID" InsertVisible="False" ReadOnly="True" SortExpression="disk_id" >
            <HeaderStyle CssClass="text-center" HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="disk_type" HeaderText="Disk Type" SortExpression="disk_type">
            <HeaderStyle CssClass="text-center" HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="genre_id" HeaderText="Genre" SortExpression="genre_id">
            <HeaderStyle CssClass="text-center" HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="release_date" DataFormatString="{0:d}" HeaderText="Release Date" SortExpression="release_date">
            <HeaderStyle CssClass="text-center" HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select" Text="Select"></asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
        <br />
        
        <div>
            Borrower:
            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="SqlDataSource2" DataTextField="borrower_first" DataValueField="borrower_id"></asp:DropDownList>
        </div>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:disk_inventoryBHConnectionString2 %>"
                SelectCommand="SELECT [borrower_id], [borrower_first]+ ' ' + [borrower_last] as borrower_first FROM [borrower]"></asp:SqlDataSource>
        
        <div>
            <asp:Label ID="lblDiskName" runat="server" Text="Disk Name: "></asp:Label><asp:Label ID="lblDiskNameOutput" runat="server"></asp:Label>
        </div>
        <div>
            <asp:Label ID="lblDiskID" runat="server" Text="Disk ID: "></asp:Label><asp:Label ID="lblDiskIDOutput" runat="server"></asp:Label>
        </div>
        <div>
            <asp:Button ID="btnCheckOut" runat="server" Text="Check Out" CssClass="btn-primary" OnClick="btnCheckOut_Click" />
        </div>
        <br />
        <asp:Label ID="lblError" runat="server" CssClass="text-danger"></asp:Label>

</div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:disk_inventoryBHConnectionString2 %>" SelectCommand="select disk_name,artist_first, artist_last, disk_info.disk_id, disk_type, genre_id, release_date  from disk_info
            left join cd_artist on cd_artist.disk_id = disk_info.disk_id
            left join artist on artist.artist_id = cd_artist.artist_id
            where disk_info.disk_status = 2 order by disk_name;"></asp:SqlDataSource>


</asp:Content>
