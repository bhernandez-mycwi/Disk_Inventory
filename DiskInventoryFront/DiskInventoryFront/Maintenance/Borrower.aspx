<%@ Page Title="Borrower" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Borrower.aspx.cs" Inherits="DiskInventoryFront.Borrower" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class =" text-center">
                             <%--Page to insert/update/delete borrowers with stored procedures--%>
        <!-- Borrower Management can only be accessed once user is authenticated -->

        <br />
            <h2>Enter Borrower Information</h2>
            <div id="Borrower">
            <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="borrower_id" DataSourceID="SqlDataSource1">
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <EditItemTemplate>
                            <asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Update" Text="Update" CssClass="btn-success" />
                            &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" CssClass="btn-warning" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Edit" Text="Edit" CssClass="btn-primary" />
                            &nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Delete" Text="Delete" CssClass="btn-danger" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="ID" InsertVisible="False" SortExpression="borrower_id">
                        <EditItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("borrower_id") %>'></asp:Label>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("borrower_id") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="First Name" SortExpression="borrower_first">
                        <EditItemTemplate>
                            <%--First Name Required--%>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("borrower_first") %>' ControlToValidate="TextBox1"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" Display="Dynamic" ErrorMessage="First Name Required" CssClass="text-danger" ControlToValidate="TextBox1"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label2" runat="server" Text='<%# Bind("borrower_first") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Last Name" SortExpression="borrower_last">
                        <EditItemTemplate>
                            <%--Last Name Required--%>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("borrower_last") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ErrorMessage="Last Name Required" ControlToValidate="TextBox2" Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("borrower_last") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Phone Number" SortExpression="borrower_phone_number">
                        <EditItemTemplate>
                            <%--Phone Required--%>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("borrower_phone_number") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ErrorMessage="Phone Number Required" ControlToValidate="TextBox3" CssClass="text-danger" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="TextBox3" CssClass="text-danger" Display="Dynamic" ErrorMessage="Please use this format(999-999-9999)" ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}"></asp:RegularExpressionValidator>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="Label4" runat="server" Text='<%# Bind("borrower_phone_number") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
        </asp:GridView>
                </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:disk_inventoryBHConnectionString2 %>" 
            DeleteCommand="EXEC sp_Delete_Borrower @borrower_id" 
            InsertCommand="EXEC sp_Insert_Borrower @borrower_first, @borrower_last, @borrower_phone_number"
            SelectCommand="SELECT [borrower_id], [borrower_first], [borrower_last], [borrower_phone_number] FROM [borrower] ORDER BY [borrower_last], [borrower_first]"
            UpdateCommand="EXEC sp_Update_Borrower @borrower_id, @borrower_first,  @borrower_last, @borrower_phone_number">
            <DeleteParameters>
                <asp:Parameter Name="borrower_id" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="borrower_first" Type="String" />
                <asp:Parameter Name="borrower_last" Type="String" />
                <asp:Parameter Name="borrower_phone_number" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="borrower_first" Type="String" />
                <asp:Parameter Name="borrower_last" Type="String" />
                <asp:Parameter Name="borrower_phone_number" Type="String" />
                <asp:Parameter Name="borrower_id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
        <h4>Enter Borrower information to add new Borrower</h4>
            <asp:Label ID="lblFirst" runat="server" Text="First Name"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtFirst" runat="server"></asp:TextBox>
    
        <p>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtFirst" CssClass="text-danger" Display="Dynamic" ErrorMessage="This field is required" ValidationGroup="borrower"></asp:RequiredFieldValidator>
    </p>
    <p>
        &nbsp;</p>
    <p>
        <asp:Label ID="lblLast" runat="server" Text="Last Name"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtLast" runat="server"></asp:TextBox>
    </p>
        <p>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtLast" CssClass="text-danger" Display="Dynamic" ErrorMessage="This field is required" ValidationGroup="borrower"></asp:RequiredFieldValidator>
    </p>
    <p>
        &nbsp;</p>
    <p>
        &nbsp;
        <asp:Label ID="lblPhone" runat="server" Text="Phone"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
    </p>
        <p>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtPhone" CssClass="text-danger" Display="Dynamic" ErrorMessage="This field is required" ValidationGroup="borrower"></asp:RequiredFieldValidator>
    </p>
        <p>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtPhone" CssClass="text-danger" Display="Dynamic" ErrorMessage="Please use this format(999-999-9999)" ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}"></asp:RegularExpressionValidator>
    </p>
    <p>
        &nbsp;</p>
    <p>
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" CssClass="btn-primary" />
    </p>
    <p>
        &nbsp;</p>
    
        </div>

    
        <div class ="container ">
            <p>
                <asp:Label ID="lblMessage" runat="server"></asp:Label>
            </p>
        
    </div>
</asp:Content>
