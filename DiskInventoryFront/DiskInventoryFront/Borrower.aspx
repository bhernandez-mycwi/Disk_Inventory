<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Borrower.aspx.cs" Inherits="DiskInventoryFront.Borrower" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class =" text-center">
        <p>
        <br />
            <h2>Enter Borrower Information</h2>
            <asp:Label ID="lblFirst" runat="server" Text="First Name"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtFirst" runat="server"></asp:TextBox>
    </p>
        <p>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtFirst" CssClass="text-danger" Display="Dynamic" ErrorMessage="This field is required"></asp:RequiredFieldValidator>
    </p>
    <p>
        &nbsp;</p>
    <p>
        <asp:Label ID="lblLast" runat="server" Text="Last Name"></asp:Label>
        &nbsp;&nbsp;&nbsp;&nbsp;
        <asp:TextBox ID="txtLast" runat="server"></asp:TextBox>
    </p>
        <p>
            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtLast" CssClass="text-danger" Display="Dynamic" ErrorMessage="This field is required"></asp:RequiredFieldValidator>
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
            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="txtPhone" CssClass="text-danger" Display="Dynamic" ErrorMessage="This field is required"></asp:RequiredFieldValidator>
    </p>
        <p>
            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ControlToValidate="txtPhone" CssClass="text-danger" Display="Dynamic" ErrorMessage="Please use this format(999-999-9999)" ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}"></asp:RegularExpressionValidator>
    </p>
    <p>
        &nbsp;</p>
    <p>
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" OnClick="btnSubmit_Click" />
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
