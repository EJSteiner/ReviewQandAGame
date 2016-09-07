using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class _Default : System.Web.UI.Page
{
    Int16 difficulty;
    Int16 points;
    Int16 categories;
    string newCategoryMsg = "Please select a category.";

    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            lblMessage1.Text = newCategoryMsg;
        }
    }

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridView1.SelectedRow.Enabled = false;
        lblMessage1.Text = "The current category is " + GridView1.SelectedValue;
        hidDifficulty.Value = "1";
        GridView1.Visible = false;

    }

    protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
    {
        string rightAnswer = GridView2.DataKeys[GridView2.SelectedIndex]["Correct"].ToString();
        if (rightAnswer == "True")
        {
            lblResponse.Text = "Correct!";
            points = Int16.Parse(lblPoints.Text);
            difficulty = Int16.Parse(hidDifficulty.Value);
            points += difficulty;
            lblPoints.Text = points.ToString();
        }
        else
        {
            lblResponse.Text = "Incorrect. Correct answer is: ";
        }
        string isCorrect;

        foreach (GridViewRow row in GridView2.Rows)
        {
            row.Cells[0].Enabled = false;
            isCorrect = GridView2.DataKeys[row.RowIndex]["Correct"].ToString();
            if ((rightAnswer == "False") && (isCorrect == "True"))
            {
                lblResponse.Text += row.Cells[1].Text;
            }
        }
        btnNext.Visible = true;
        
    }



    protected void btnNext_Click(object sender, EventArgs e)
    {
        lblResponse.Text = "";
        btnNext.Visible = false;
        difficulty = Int16.Parse(hidDifficulty.Value);
        if (difficulty == 5)
        {
            GridView1.Visible = true;
            if (moreCategories() == true)
            {
                difficulty = 0;
                lblMessage1.Text = newCategoryMsg;
            }
            else
            {
                lblMessage1.Text = "Game Finished!";
                lblResponse.Text = "You earned " + lblPoints.Text + " out of 90 points";
                FormView1.Visible = false;
                GridView2.Visible = false;
            }

        }
        else
        {
            difficulty++;
        }
        hidDifficulty.Value = difficulty.ToString();
    }

    private bool moreCategories()
    {

        categories = Int16.Parse(lblCategoryCount.Text);
        categories++;
        lblCategoryCount.Text = categories.ToString();
        if (GridView1.Rows.Count > categories)
        {
            return true;
        }
        else
        {

            return false; 
        }
    }
}