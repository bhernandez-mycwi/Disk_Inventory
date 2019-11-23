<%@ Page Title="Disk Info" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Disks.aspx.cs" Inherits="DiskInventoryFront.Disks" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <p>
    <br />
</p>
    
    <h1>Disk Information</h1>
    <%-- Page to insert/update/delete Disk Info using stored procedures--%>
<p class="text-center">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:disk_inventoryBHConnectionString2 %>" 
        DeleteCommand="exec sp_Delete_DiskInfo @disk_id" 
        InsertCommand="EXEC sp_Insert_DiskInfo @disk_name, @disk_status, @disk_type, @genre_id, @release_date" 
        SelectCommand="SELECT disk_id, disk_name, disk_status, disk_type, genre_id, convert(varchar(10), release_date, 120) as release_date FROM disk_info" 
        UpdateCommand="EXEC sp_Update_DiskInfo @disk_id, @disk_name, @disk_status, @disk_type, @genre_id, @release_date">
        <DeleteParameters>
            <asp:Parameter Name="disk_id" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="disk_name" Type="String" />
            <asp:Parameter Name="disk_status" Type="Int32" />
            <asp:Parameter Name="disk_type" Type="Int32" />
            <asp:Parameter Name="genre_id" Type="Int32" />
            <asp:Parameter DbType="Date" Name="release_date" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="disk_id" Type="Int32" />
            <asp:Parameter Name="disk_name" />
            <asp:Parameter Name="disk_status" />
            <asp:Parameter Name="disk_type" />
            <asp:Parameter Name="genre_id" />
            <asp:Parameter Name="release_date" />
        </UpdateParameters>
    </asp:SqlDataSource>
</p>
    
        <div id="Disks">
    <asp:ListView ID="ListView1" runat="server" DataKeyNames="disk_id" DataSourceID="SqlDataSource1" InsertItemPosition="LastItem" style="margin-right: 0px">
        
        <AlternatingItemTemplate>
            <tr style="" >
                <td>
                    <asp:Button ID="DeleteButton" runat="server" CommandName="Delete" Text="Delete" CausesValidation="False"  CssClass="btn-danger" />
                    <asp:Button ID="EditButton" runat="server" CommandName="Edit" Text="Edit" CausesValidation="False" CssClass="btn-primary" />
                </td>
                <td>
                    <asp:Label ID="disk_idLabel" runat="server" Text='<%# Eval("disk_id") %>' />
                </td>
                <td>
                    <asp:Label ID="disk_nameLabel" runat="server" Text='<%# Eval("disk_name") %>' />
                </td>
                <td>
                    <asp:Label ID="disk_statusLabel" runat="server" Text='<%# Eval("disk_status") %>' />
                </td>
                <td>
                    <asp:Label ID="disk_typeLabel" runat="server" Text='<%# Eval("disk_type") %>' />
                </td>
                <td>
                    <asp:Label ID="genre_idLabel" runat="server" Text='<%# Eval("genre_id") %>' />
                </td>
                <td>
                    <asp:Label ID="release_dateLabel" runat="server" Text='<%# Eval("release_date") %>' />
                </td>
            </tr>
        </AlternatingItemTemplate>
        <EditItemTemplate>

            <tr style="">
                <td>
                    <asp:Button ID="UpdateButton" runat="server" CommandName="Update" Text="Update" CausesValidation="True" ValidationGroup="update" CssClass="btn-success" />
                    <asp:Button ID="CancelButton" runat="server" CommandName="Cancel" Text="Cancel" CausesValidation="False" CssClass="btn-warning" />
                </td>
                <td>
                    <asp:Label ID="disk_idLabel1" runat="server" Text='<%# Eval("disk_id") %>' />

                </td>
                <td>
                    <%-- Disk Name cannot accept nulls --%>
                    <asp:TextBox ID="disk_nameTextBox" runat="server" Text='<%# Bind("disk_name") %>' ValidationGroup="update" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Disk Name is required" CssClass="text-danger" Display="Dynamic" ControlToValidate="disk_nameTextBox" ValidationGroup="update"></asp:RequiredFieldValidator>
                </td>
                <td>
                  <%-- Status requires validation for data type, cannot accept nulls, and must be either 1 or 2 --%>

                    <asp:TextBox ID="disk_statusTextBox" runat="server" Text='<%# Bind("disk_status") %>' />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="Disk Status is required" ControlToValidate="disk_statusTextBox" Display="Dynamic" CssClass="text-danger" ValidationGroup="update"></asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="RangeValidator4" runat="server" ErrorMessage="Status must be either a 1 or 2" ControlToValidate="disk_statusTextBox" CssClass="text-danger" Display="Dynamic" MaximumValue="2" MinimumValue="1" Type="Integer" ValidationGroup="update"></asp:RangeValidator>
                    <asp:CompareValidator ID="CompareValidator3" runat="server" ControlToValidate="disk_statusTextBox" Display="Dynamic" CssClass="text-danger" ErrorMessage="Status must be a whole number" Type="Integer" Operator="DataTypeCheck" ValidationGroup="update"></asp:CompareValidator>

                </td>
                <td>
                   <%-- Disk Type requires validation for data type, cannot accept nulls, and must be either 1 or 2 --%>

                    <asp:TextBox ID="disk_typeTextBox" runat="server" Text='<%# Bind("disk_type") %>'  />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" CssClass="text-danger" Display="Dynamic" ErrorMessage="Disk Type is required" ControlToValidate="disk_typeTextBox" ValidationGroup="update"></asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="RangeValidator5" runat="server" ErrorMessage="Type must be either a 1 or 2" ControlToValidate="disk_typeTextBox" CssClass="text-danger" Display="Dynamic" MaximumValue="2" MinimumValue="1" Type="Integer" ValidationGroup="update"></asp:RangeValidator>
                    <asp:CompareValidator ID="CompareValidator4" runat="server" ControlToValidate="disk_typeTextBox" Display="Dynamic" CssClass="text-danger" ErrorMessage="Type must be a whole number" Type="Integer" Operator="DataTypeCheck" ValidationGroup="update"></asp:CompareValidator>
                </td>
                <td>
                   <%-- Genre requires validation for data type, cannot accept nulls, and must a value between 1 and 4 --%>

                    <asp:TextBox ID="genre_idTextBox" runat="server" Text='<%# Bind("genre_id") %>' ControlToValidate="genre_idTextBox" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ErrorMessage="Genre is required" CssClass="text-danger" Display="Dynamic" ControlToValidate="genre_idTextBox" ValidationGroup="update"></asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="RangeValidator6" runat="server" ErrorMessage="Genre must be between 1 and 4" ControlToValidate="genre_idTextBox" CssClass="text-danger" Display="Dynamic" MaximumValue="4" MinimumValue="1" Type="Integer" ValidationGroup="update"></asp:RangeValidator>
                    <asp:CompareValidator ID="CompareValidator5" runat="server" ControlToValidate="genre_idTextBox" Display="Dynamic" CssClass="text-danger" ErrorMessage="Genre must be a whole number" Type="Integer" Operator="DataTypeCheck" ValidationGroup="update"></asp:CompareValidator>
                </td>
                <td>
                    <%-- Date requires validation for data type and cannot accept nulls--%>
                    <asp:TextBox ID="release_dateTextBox" runat="server" Text='<%# Bind("release_date") %>' />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" CssClass="text-danger" Display="Dynamic" ErrorMessage="Release Date is required" ControlToValidate="release_dateTextBox" ValidationGroup="update"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator2" runat="server" ErrorMessage="Incorrect Date format" ControlToValidate="release_dateTextBox" Display="Dynamic" CssClass="text-danger" Operator="DataTypeCheck" Type="Date" ValidationGroup="update"></asp:CompareValidator>
                </td>
            </tr>
        </EditItemTemplate>
        <EmptyDataTemplate>
            <table runat="server" style="">
                <tr>
                    <td>No data was returned.</td>
                </tr>
            </table>
        </EmptyDataTemplate>
        <InsertItemTemplate>
            <tr style="">
                <td>
                    <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="Insert" />
                    <asp:Button ID="CancelButton0" runat="server" CommandName="Cancel" Text="Clear" CausesValidation="False" />
                </td>
                <td>&nbsp;</td>
                <td>
                    <%-- Disk Name cannot accept nulls--%>
                    <asp:TextBox ID="disk_nameTextBox2" runat="server" Text='<%# Bind("disk_name") %>' />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Disk Name is required" Display="Dynamic" CssClass="text-danger" ControlToValidate="disk_nameTextBox2">*</asp:RequiredFieldValidator>
                </td>
                <td>
                    <%-- Disk Status requires validation for data type, cannot accept nulls, and must be either 1 or 2 --%>
                    <asp:TextBox ID="disk_statusTextBox2" runat="server" Text='<%# Bind("disk_status") %>' />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ErrorMessage="Disk Status is required" ControlToValidate="disk_statusTextBox2" CssClass="text-danger" Display="Dynamic">*</asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="RangeValidator1" runat="server" CssClass="text-danger" Display="Dynamic" ErrorMessage="Disk Status must be either a 1 or 2" ControlToValidate="disk_statusTextBox2" MaximumValue="2" MinimumValue="1">*</asp:RangeValidator>
                </td>
                <td>
                    <%-- Disk Type requires validation for data type, cannot accept nulls, and must be either 1 or 2 --%>
                    <asp:TextBox ID="disk_typeTextBox2" runat="server" Text='<%# Bind("disk_type") %>' />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" CssClass="text-danger" Display="Dynamic" ErrorMessage="Disk Type is required" ControlToValidate="disk_typeTextBox2">*</asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="RangeValidator2" runat="server" CssClass="text-danger" Display="Dynamic" ErrorMessage="Disk Status must be either a 1 or 2" ControlToValidate="disk_typeTextBox2" MaximumValue="2" MinimumValue="1">*</asp:RangeValidator>
                </td>
                <td>
                    <%-- Genre requires validation for data type, cannot accept nulls, and must be between 1 and 4--%>
                    <asp:TextBox ID="genre_idTextBox2" runat="server" Text='<%# Bind("genre_id") %>' ControlToValidate="genre_idTextBox2" />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" CssClass="text-danger" Display="Dynamic" ErrorMessage="Disk Genre is required" ControlToValidate="genre_idTextBox2">*</asp:RequiredFieldValidator>
                    <asp:RangeValidator ID="RangeValidator3" runat="server" CssClass="text-danger" Display="Dynamic" ErrorMessage="Disk Status must be either a 1 or 2" ControlToValidate="genre_idTextBox2" MaximumValue="4" MinimumValue="1">*</asp:RangeValidator>
                </td>
                <td>
                    <%-- Date requires validation for data type and annot accept nulls --%>
                    <asp:TextBox ID="release_dateTextBox2" runat="server" Text='<%# Bind("release_date") %>' />
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ErrorMessage="Release Date is required" ControlToValidate="release_dateTextBox2" CssClass="text-danger">*</asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ErrorMessage="Incorrect Date format" Display="Dynamic" CssClass="text-danger" ControlToValidate="release_dateTextBox2" Type="Date" Operator="DataTypeCheck">*</asp:CompareValidator>
                </td>
            </tr>
        </InsertItemTemplate>
        <ItemTemplate>
            <tr style="">
                <td>
                    <asp:Button ID="DeleteButton0" runat="server" CommandName="Delete" Text="Delete" CssClass="btn-danger" />
                    <asp:Button ID="EditButton0" runat="server" CommandName="Edit" Text="Edit" CausesValidation="False" CssClass="btn-primary" />
                </td>
                <td>
                    <asp:Label ID="disk_idLabel2" runat="server" Text='<%# Eval("disk_id") %>' />
                </td>
                <td>
                    <asp:Label ID="disk_nameLabel0" runat="server" Text='<%# Eval("disk_name") %>' />
                </td>
                <td>
                    <asp:Label ID="disk_statusLabel0" runat="server" Text='<%# Eval("disk_status") %>' />
                </td>
                <td>
                    <asp:Label ID="disk_typeLabel0" runat="server" Text='<%# Eval("disk_type") %>' />
                </td>
                <td>
                    <asp:Label ID="genre_idLabel0" runat="server" Text='<%# Eval("genre_id") %>' />
                </td>
                <td>
                    <asp:Label ID="release_dateLabel0" runat="server" Text='<%# Eval("release_date") %>' />
                </td>
            </tr>
        </ItemTemplate>
        <LayoutTemplate>
            <table runat="server">
                <tr runat="server">
                    <td runat="server">
                        <table id="itemPlaceholderContainer" runat="server" border="0" style="">
                            <tr runat="server" style="">
                                <th runat="server"></th>
                                <th runat="server">disk_id</th>
                                <th runat="server">disk_name</th>
                                <th runat="server">disk_status</th>
                                <th runat="server">disk_type</th>
                                <th runat="server">genre_id</th>
                                <th runat="server">release_date</th>
                            </tr>
                            <tr id="itemPlaceholder" runat="server">
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr runat="server">
                    <td runat="server" style="">
                        <asp:DataPager ID="DataPager1" runat="server">
                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Button" ShowFirstPageButton="True" ShowLastPageButton="True" />
                            </Fields>
                        </asp:DataPager>
                    </td>
                </tr>
            </table>
        </LayoutTemplate>
        <SelectedItemTemplate>
            <tr style="">
                <td>
                    <asp:Button ID="DeleteButton1" runat="server" CommandName="Delete" Text="Delete" />
                    <asp:Button ID="EditButton1" runat="server" CommandName="Edit" Text="Edit" />
                </td>
                <td>
                    <asp:Label ID="disk_idLabel3" runat="server" Text='<%# Eval("disk_id") %>' />
                </td>
                <td>
                    <asp:Label ID="disk_nameLabel1" runat="server" Text='<%# Eval("disk_name") %>' />
                </td>
                <td>
                    <asp:Label ID="disk_statusLabel1" runat="server" Text='<%# Eval("disk_status") %>' />
                </td>
                <td>
                    <asp:Label ID="disk_typeLabel1" runat="server" Text='<%# Eval("disk_type") %>' />
                </td>
                <td>
                    <asp:Label ID="genre_idLabel1" runat="server" Text='<%# Eval("genre_id") %>' />
                </td>
                <td>
                    <asp:Label ID="release_dateLabel1" runat="server" Text='<%# Eval("release_date") %>' />
                </td>
            </tr>
        </SelectedItemTemplate>
    </asp:ListView>
            </div>
    

    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="text-danger" DisplayMode="List" />
</asp:Content>
