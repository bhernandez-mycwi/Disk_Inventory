<%@ Page Title="Artists" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Artists.aspx.cs" Inherits="DiskInventoryFront.Artists" %>
    <%-- Page to insert/update/delete Artist Info using stored procedures--%>

<asp:Content ID="Content1" runat="server" contentplaceholderid="MainContent">
    <h1>Artist Information</h1>
    <div id="Main1">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="artist_id" DataSourceID="SqlDataSource1" AllowSorting="True">
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <EditItemTemplate>
                    <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Update" Text="Update" ValidationGroup="Update" />
                    <%-- Remove validation from cancel button--%>
                    <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" />
                    &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Artist First" SortExpression="artist_first">
                <EditItemTemplate>
                    <%-- First name  cannot accept nulls --%>
                    <asp:TextBox ID="txtFirst" runat="server" Text='<%# Bind("artist_first") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="The artist first name is required to update" ControlToValidate="txtFirst" Text="Required" CssClass="text-danger" Display="Dynamic" ValidationGroup="Update"></asp:RequiredFieldValidator>
                    
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("artist_first") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Artist Last" SortExpression="artist_last">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("artist_last") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("artist_last") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="Type ID" SortExpression="artist_type_id">
                <EditItemTemplate>
                    <%-- Artist Type must be an integer, cannot accept nulls, and must be between 1 and 2 --%>
                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("artist_type_id") %>'></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="The artist type is required to update" Display="Dynamic" Text="Required" CssClass="text-danger" ControlToValidate="TextBox3" ValidationGroup="Update"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="TextBox3" Display="Dynamic" CssClass="text-danger" ErrorMessage="The artist type must be an integer" Type="Integer" Operator="DataTypeCheck" ValidationGroup="Update">Type must be a whole number</asp:CompareValidator>
                    <asp:RangeValidator ID="RangeValidator2" runat="server" ErrorMessage="RangeValidator" ControlToValidate="TextBox3" CssClass="text-danger" Display="Dynamic" Text="Artist type must be either 1 or 2" MaximumValue="2" MinimumValue="1" ValidationGroup="Update"></asp:RangeValidator>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label3" runat="server" Text='<%# Bind("artist_type_id") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="artist_id" HeaderText="ID" SortExpression="artist_id" InsertVisible="False" ReadOnly="True" />
        </Columns>
        
    </asp:GridView>
        <br />
        <div class="col-sm-4">
        <asp:Label ID="lblFirst" runat="server" Text="Artist First Name:"></asp:Label>
            </div>
        <div class="col-sm-6">
        <asp:TextBox ID="txtFirst" runat="server" ValidationGroup="Summary"></asp:TextBox>
            <%--Artist first name cannot accept nulls --%>
        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Artist first name is required" ControlToValidate="txtFirst" CssClass="text-danger" Display="Dynamic">*</asp:RequiredFieldValidator>
            </div>
        <br />
        <div class="col-sm-4">
        <asp:Label ID="lblLast" runat="server" Text="Artist Last Name:"></asp:Label>
            </div>
        <div class="col-sm-6">
        <asp:TextBox ID="txtLast" runat="server"></asp:TextBox>
            
            </div>
        <br />
        <div class="col-sm-4">
        <asp:Label ID="lblType" runat="server" Text="Artist Type:"></asp:Label>
            
            </div>
        <div class="col-sm-6">
        <asp:TextBox ID="txtType" runat="server" ></asp:TextBox>
            <%-- Type name cannot accept nulls, must be an integer, and must be either a 1 or 2 --%>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ErrorMessage="Artist type is Required" ControlToValidate="txtType" CssClass="text-danger" Display="Dynamic">*</asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="CompareValidator" ControlToValidate="txtType" Type="Integer" Operator="DataTypeCheck" Display="Dynamic"></asp:CompareValidator>
            <asp:RangeValidator ID="RangeValidator1" runat="server" ControlToValidate="txtType" Display="Dynamic" ErrorMessage="Artist Type must be either a 1 or a 2" Text="*" CssClass="text-danger" MaximumValue="2" MinimumValue="1" Type="Integer"></asp:RangeValidator>
            </div>
       
        <div class ="col-sm-6">
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn-primary" OnClick="btnSubmit_Click" />
        </div>
        <div class="col-sm-6">
            <asp:Button ID="btnClear" runat="server" Text="Clear" OnClick="btnClear_Click" CssClass="btn-primary" CausesValidation="False" />
        </div>
        <br />
        <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="text-danger" DisplayMode="List" />
        <asp:Label ID="lblError" runat="server"></asp:Label>
            
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:disk_inventoryBHConnectionString2 %>" 
            SelectCommand="SELECT [artist_first], [artist_last], [artist_type_id], [artist_id] FROM [artist] ORDER BY [artist_last], [artist_first]" 
            DeleteCommand="sp_Delete_Artist" DeleteCommandType="StoredProcedure" 
            InsertCommand="INSERT INTO [artist] ([artist_first], [artist_last], [artist_type_id]) VALUES (@artist_first, @artist_last, @artist_type_id)"  
            UpdateCommand="sp_Update_Artist" UpdateCommandType="StoredProcedure">
            <DeleteParameters>
                <asp:Parameter Name="artist_id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="artist_first" Type="String" />
                <asp:Parameter Name="artist_last" Type="String" />
                <asp:Parameter Name="artist_type_id" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="artist_id" Type="Int32" />
                <asp:Parameter Name="artist_first" Type="String" />
                <asp:Parameter Name="artist_last" Type="String" />
                <asp:Parameter Name="artist_type_id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        </div>
  
</asp:Content>

