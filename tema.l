%{
#include <stdio.h>

#undef yywrap

int count_vertexes;
int count_textures;
int count_faces;
int is_texture;
char image[100];

int count_tabs;
int inner_object_found = 0;

%}
object_keyword 			"Object"
object_name 			[a-zA-Z][a-zA-Z_0-9]+
begin_paranthesis		"{"
end_paranthesis			"}"
vertexes_keyword		"vertexes"
texture_keyword			"texture"
faces_keyword			"faces"
img_keyword				"img"

digit					[0-9]
sign					[+-]?
natural_number			{digit}+
float_number			{sign}{natural_number}\.{natural_number}?

real_number_0_1			"0"\.{natural_number}?
texture_number			"("{real_number_0_1}[ \n\t]+{real_number_0_1}")"

vertex_cartesian		"("{float_number}[ \n\t]+{float_number}[ \n\t]+{float_number}")"
vertex_homogenous		"("{float_number}[ \n\t]+{float_number}[ \n\t]+{float_number}[ \n\t]+{float_number}")"

face_aux				{natural_number}[ \n\t]+
face					{face_aux}+{natural_number}";"

texture_image_name		[^ \n]+

%s MAY_BE_OBJECT_FOUND GET_OBJECT_PROPERTIES CHECK_PARANTHESIS COUNT_VERTEXES COUNT_TEXTURES COUNT_FACES
%s GET_IMAGE_NAME

%%
<INITIAL>{object_keyword}					{
												count_tabs = 0;
												BEGIN(MAY_BE_OBJECT_FOUND);
											}
<MAY_BE_OBJECT_FOUND>{object_name}			{
												count_vertexes = 0;
												count_textures = 0; 
												count_faces = 0;
												inner_object_found = 0;
												is_texture = 0;
												for (int i = 0; i < count_tabs; i++) {
													printf("\t");
												}
												printf("Object %s: ", yytext);
												BEGIN(CHECK_PARANTHESIS);
											}

<CHECK_PARANTHESIS>{begin_paranthesis}		{
												BEGIN(GET_OBJECT_PROPERTIES);
											}

<GET_OBJECT_PROPERTIES>{vertexes_keyword}	{
												printf("varfuri: ");
												BEGIN(COUNT_VERTEXES);
											}
<GET_OBJECT_PROPERTIES>{texture_keyword}	{
												BEGIN(COUNT_TEXTURES);
											}
<GET_OBJECT_PROPERTIES>{faces_keyword}		{
												printf("fete: ");
												BEGIN(COUNT_FACES);
											}
<GET_OBJECT_PROPERTIES>{img_keyword}		{
												is_texture = 1;
												BEGIN(GET_IMAGE_NAME);
											}
<GET_OBJECT_PROPERTIES>{object_keyword}		{
												if (inner_object_found == 0) {
													if (is_texture == 1) {
														printf(", imagine textura %s\n", image);
													} else {
														printf(", fara textura\n");
													}
												}
												count_tabs++;
												inner_object_found = 1;
												BEGIN(MAY_BE_OBJECT_FOUND);
											}
<GET_OBJECT_PROPERTIES>{end_paranthesis}	{
												if (inner_object_found == 0) {
													if (is_texture == 1) {
														printf(", imagine textura %s\n", image);
													} else {
														printf(", fara textura\n");
													}
												}
												if (count_tabs != 0) {
													count_tabs--;
													inner_object_found = 1;
													BEGIN(GET_OBJECT_PROPERTIES);
												} else {
													inner_object_found = 1;
													BEGIN(INITIAL);
												}
											}

<COUNT_VERTEXES>{vertex_cartesian}			{count_vertexes++;}
<COUNT_VERTEXES>{vertex_homogenous}			{count_vertexes++;}
<COUNT_VERTEXES>"\n"						{printf("%d, ", count_vertexes); BEGIN(GET_OBJECT_PROPERTIES);}

<COUNT_TEXTURES>{texture_number}			{count_textures++;}
<COUNT_TEXTURES>"\n"						{BEGIN(GET_OBJECT_PROPERTIES);}

<COUNT_FACES>{face}							{count_faces++;}
<COUNT_FACES>"\n"							{printf("%d", count_faces); BEGIN(GET_OBJECT_PROPERTIES);}

<GET_IMAGE_NAME>{texture_image_name}		{strcpy(image, yytext);}
<GET_IMAGE_NAME>"\n"						{BEGIN(GET_OBJECT_PROPERTIES);}

.|\n|\t										;
%%

char** list_files;
int current_file;
int nr_files;

void main(int argc, char **argv) {
	FILE *file;
	list_files = argv + 1;
	nr_files = argc - 1;
	current_file = 0;

	if (argc > 1) {
		file = fopen(list_files[current_file], "r");
		if (!file) {
			printf("Error!\n");
			exit(1);
		}
		yyin = file;
		yylex();
	}
}

int yywrap() {
	FILE *file = NULL;

	fclose(yyin);
	current_file++;
	
	if (current_file >= nr_files) {
		return 1;
	}
	file = fopen(list_files[current_file], "r");
	if (!file) {
		printf("Error!\n");
		exit(1);
	}
	yyin = file;
	return (file ? 0:1);
}
