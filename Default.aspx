<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style>
        .showRight {
            float: right;
            display: inline-block;
            font-weight: bold;
            color: blue;
            margin-right:100px;
        }
        td {
            padding-left:3px;
            padding-right:3px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <h1>Review Q&A Game</h1>
        <p>
            For each category selected, the game will display a series of 5 increasingly difficult questions. 
            Questions must be answered in the sequence displayed.
            Each topic may be selected only once.
        </p>
        <div>
            <span class="showRight">
                <asp:Literal ID="Literal2" runat="server">Categories Completed: </asp:Literal>
                <asp:Label ID="lblCategoryCount" runat="server" Text="0"></asp:Label>
                <br />
                <asp:Literal ID="Literal1" runat="server">Points: </asp:Literal>
                <asp:Label ID="lblPoints" runat="server" Text="0" ClientIDMode="Static"></asp:Label>
            </span>
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" DataKeyNames="Category">
                <Columns>
                    <asp:CommandField ButtonType="Button" ShowSelectButton="True" />
                    <asp:BoundField DataField="Category" HeaderText="Category" SortExpression="Category" />
                </Columns>
            </asp:GridView>

        </div>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ReviewQandAConnectionString %>" SelectCommand="getCategories" SelectCommandType="StoredProcedure"></asp:SqlDataSource>
        <asp:HiddenField ID="hidDifficulty" runat="server" />
        <br />
        <br />
        <h2>
            <asp:Label ID="lblMessage1" runat="server" Text="Label"></asp:Label>
        </h2>
        <p>
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="QID,AID" DataSourceID="SqlQuestionAnswers">
                <EditItemTemplate>
                    QID:
                    <asp:Label ID="QIDLabel1" runat="server" Text='<%# Eval("QID") %>' />
                    <br />
                    Difficulty:
                    <asp:TextBox ID="DifficultyTextBox" runat="server" Text='<%# Bind("Difficulty") %>' />
                    <br />
                    Question:
                    <asp:TextBox ID="QuestionTextBox" runat="server" Text='<%# Bind("Question") %>' />
                    <br />
                    Category:
                    <asp:TextBox ID="CategoryTextBox" runat="server" Text='<%# Bind("Category") %>' />
                    <br />
                    AID:
                    <asp:Label ID="AIDLabel1" runat="server" Text='<%# Eval("AID") %>' />
                    <br />
                    QID1:
                    <asp:TextBox ID="QID1TextBox" runat="server" Text='<%# Bind("QID1") %>' />
                    <br />
                    Answer:
                    <asp:TextBox ID="AnswerTextBox" runat="server" Text='<%# Bind("Answer") %>' />
                    <br />
                    Correct:
                    <asp:CheckBox ID="CorrectCheckBox" runat="server" Checked='<%# Bind("Correct") %>' />
                    <br />
                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update" Text="Update" />
                    &nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                </EditItemTemplate>
                <InsertItemTemplate>
                    Difficulty:
                    <asp:TextBox ID="DifficultyTextBox" runat="server" Text='<%# Bind("Difficulty") %>' />
                    <br />
                    Question:
                    <asp:TextBox ID="QuestionTextBox" runat="server" Text='<%# Bind("Question") %>' />
                    <br />
                    Category:
                    <asp:TextBox ID="CategoryTextBox" runat="server" Text='<%# Bind("Category") %>' />
                    <br />

                    QID1:
                    <asp:TextBox ID="QID1TextBox" runat="server" Text='<%# Bind("QID1") %>' />
                    <br />
                    Answer:
                    <asp:TextBox ID="AnswerTextBox" runat="server" Text='<%# Bind("Answer") %>' />
                    <br />
                    Correct:
                    <asp:CheckBox ID="CorrectCheckBox" runat="server" Checked='<%# Bind("Correct") %>' />
                    <br />
                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert" Text="Insert" />
                    &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="Cancel" />
                </InsertItemTemplate>
                <ItemTemplate>
                    Question:
                    <asp:Label ID="QuestionLabel" runat="server" Text='<%# Bind("Question") %>' />
                    <br />
                </ItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="SqlQuestionAnswers" runat="server" ConnectionString="<%$ ConnectionStrings:ReviewQandAConnectionString %>" SelectCommand="QuestionAnswers" SelectCommandType="StoredProcedure">
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="Category" PropertyName="SelectedValue" Type="String" />
                    <asp:ControlParameter ControlID="hidDifficulty" Name="Difficulty" PropertyName="Value" Type="Int16" />
                </SelectParameters>
            </asp:SqlDataSource>
        </p>
        <p>
            &nbsp;
        </p>
        <p>
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="QID,AID,Correct" DataSourceID="SqlQuestionAnswers" OnSelectedIndexChanged="GridView2_SelectedIndexChanged">
                <Columns>
                    <asp:CommandField ShowSelectButton="True" />
                    <asp:BoundField DataField="Answer" HeaderText="Answer" SortExpression="Answer" ItemStyle-Width="600">
                        <ItemStyle Width="600px"></ItemStyle>
                    </asp:BoundField>
                    <asp:CheckBoxField DataField="Correct" HeaderText="Correct" SortExpression="Correct" Visible="False" />
                </Columns>
            </asp:GridView>
        </p>
        <p>
            &nbsp;
        </p>
        <h3>
            <asp:Label ID="lblResponse" runat="server" Text=""></asp:Label>
        </h3>
        <p>
            &nbsp;</p>
        <asp:Button ID="btnNext" runat="server" ClientIDMode="Static" OnClick="btnNext_Click" Text="Next Question" Visible="False" />
    </form>
</body>
</html>
