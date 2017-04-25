/*
All widgets inherit the following properties available to you:

property name="categoryService"			inject="id:categoryService@cb";
property name="entryService"			inject="id:entryService@cb";
property name="pageService"				inject="id:pageService@cb";
property name="contentService"			inject="id:contentService@cb";
property name="contentVersionService"	inject="id:contentVersionService@cb";
property name="authorService"			inject="id:authorService@cb";
property name="commentService"			inject="id:commentService@cb";
property name="customHTMLService"		inject="id:customHTMLService@cb";
property name="cb"						inject="id:CBHelper@cb";
property name="securityService" 		inject="id:securityService@cb";
property name="html"					inject="coldbox:plugin:HTMLHelper";
*/

component extends="contentbox.models.ui.BaseWidget" singleton{

	DonationForm function init(required any controller){
		// super init
		super.init( arguments.controller );

		// Widget Properties
		setName( "DonationForm" );
		setVersion( "1.1" );
		setDescription( "A widget that renders donation forms." );
		setAuthor( "Computer Know How" );
		setAuthorURL( "http://www.compknowhow.com" );
		setIcon( "list" );
		setCategory( "Content" );

		return this;
	}

	/**
	* @formType.label Form Type
	* @formType.hint Type of form
	* @formType.optionsUDF getFormTypes
	*/
	any function renderIt(string formType = "simple") {
		return runEvent(event='donation:form.render', eventArguments=arguments);;
	}

	/**
	* Return an array of form types, the @ignore annotation means the ContentBox widget editors do not use it only used internally.
	* @cbignore
	*/
	array function getFormTypes(){
		return ["simple","full"];
	}

}