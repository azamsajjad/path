--------------------------------------------------------------------------
Base Template - HTML
# This template, which we’ll call base.html, defines a simple HTML skeleton document that you might use for a simple two-column page. It’s the job of “child” templates to fill the empty blocks with content:

<!DOCTYPE html>
<html lang="en">
<head>
    {% block head %}
    <link rel="stylesheet" href="style.css" />
    <title>{% block title %}{% endblock %} - My Webpage</title>
    {% endblock %}
</head>
<body>
    <div id="content">{% block content %}{% endblock %}</div>
    <div id="footer">
        {% block footer %}
        &copy; Copyright 2008 by <a href="http://domain.invalid/">you</a>.
        {% endblock %}
    </div>
</body>
</html>
# In this example, the {% block %} tags define four blocks that child templates can fill in. All the block tag does is tell the template engine that a child template may override those placeholders in the template.

Child Template
# A child template might look like this:

{% extends "base.html" %}
{% block title %}Index{% endblock %}
{% block head %}
    {{ super() }}
    <style type="text/css">
        .important { color: #336699; }
    </style>
{% endblock %}
{% block content %}
    <h1>Index</h1>
    <p class="important">
      Welcome to my awesome homepage.
    </p>
{% endblock %}
# The {% extends %} tag is the key here. It tells the template engine that this template “extends” another template. When the template system evaluates this template, it first locates the parent. The extends tag should be the first tag in the template. Everything before it is printed out normally and may cause confusion. For details about this behavior and how to take advantage of it, see Null-Master Fallback. Also a block will always be filled in regardless of whether the surrounding condition is evaluated to be true or false.

# The filename of the template depends on the template loader. For example, the FileSystemLoader allows you to access other templates by giving the filename. You can access templates in subdirectories with a slash:

{% extends "layout/default.html" %}
# But this behavior can depend on the application embedding Jinja. Note that since the child template doesn’t define the footer block, the value from the parent template is used instead.

# You can’t define multiple {% block %} tags with the same name in the same template. This limitation exists because a block tag works in “both” directions. That is, a block tag doesn’t just provide a placeholder to fill - it also defines the content that fills the placeholder in the parent. If there were two similarly-named {% block %} tags in a template, that template’s parent wouldn’t know which one of the blocks’ content to use.

# If you want to print a block multiple times, you can, however, use the special self variable and call the block with that name:

<title>{% block title %}{% endblock %}</title>
<h1>{{ self.title() }}</h1>
{% block body %}{% endblock %}


-----------------------------------------------------------------------
List of Control Structures
# A control structure refers to all those things that control the flow of a program - conditionals (i.e. if/elif/else), for-loops, as well as things like macros and blocks. With the default syntax, control structures appear inside {% ... %} blocks.

---------------------------For-------------------------------------------
Loop over each item in a sequence. For example, to display a list of users provided in a variable called users:

<h1>Members</h1>
<ul>
{% for user in users %}
  <li>{{ user.username|e }}</li>
{% endfor %}
</ul>
As variables in templates retain their object properties, it is possible to iterate over containers like dict:

<dl>
{% for key, value in my_dict.items() %}
    <dt>{{ key|e }}</dt>
    <dd>{{ value|e }}</dd>
{% endfor %}
</dl>
Note, however, that Python dicts are not ordered; so you might want to either pass a sorted list of tuple s – or a collections.OrderedDict – to the template, or use the dictsort filter.

Inside of a for-loop block, you can access some special variables:

Variable

Description

loop.index - The current iteration of the loop. (1 indexed)

loop.index0 - The current iteration of the loop. (0 indexed)

loop.revindex - The number of iterations from the end of the loop (1 indexed)

loop.revindex0 - The number of iterations from the end of the loop (0 indexed)

loop.first - True if first iteration.

loop.last - True if last iteration.

loop.length - The number of items in the sequence.

loop.cycle - A helper function to cycle between a list of sequences. See the explanation below.

loop.depth - Indicates how deep in a recursive loop the rendering currently is. Starts at level 1

loop.depth0 - Indicates how deep in a recursive loop the rendering currently is. Starts at level 0

loop.previtem - The item from the previous iteration of the loop. Undefined during the first iteration.

loop.nextitem - The item from the following iteration of the loop. Undefined during the last iteration.

loop.changed(*val) - True if previously called with a different value (or not called at all).

Within a for-loop, it’s possible to cycle among a list of strings/variables each time through the loop by using the special loop.cycle helper:

{% for row in rows %}
    <li class="{{ loop.cycle('odd', 'even') }}">{{ row }}</li>
{% endfor %}
Since Jinja 2.1, an extra cycle helper exists that allows loop-unbound cycling. For more information, have a look at the List of Global Functions.

Unlike in Python, it’s not possible to break or continue in a loop. You can, however, filter the sequence during iteration, which allows you to skip items. The following example skips all the users which are hidden:

{% for user in users if not user.hidden %}
    <li>{{ user.username|e }}</li>
{% endfor %}
The advantage is that the special loop variable will count correctly; thus not counting the users not iterated over.

If no iteration took place because the sequence was empty or the filtering removed all the items from the sequence, you can render a default block by using else:

<ul>
{% for user in users %}
    <li>{{ user.username|e }}</li>
{% else %}
    <li><em>no users found</em></li>
{% endfor %}
</ul>
# Note that, in Python, else blocks are executed whenever the corresponding loop did not break. Since Jinja loops cannot break anyway, a slightly different behavior of the else keyword was chosen.

# It is also possible to use loops recursively. This is useful if you are dealing with recursive data such as sitemaps or RDFa. To use loops recursively, you basically have to add the recursive modifier to the loop definition and call the loop variable with the new iterable where you want to recurse.

The following example implements a sitemap with recursive loops:

<ul class="sitemap">
{%- for item in sitemap recursive %}
    <li><a href="{{ item.href|e }}">{{ item.title }}</a>
    {%- if item.children -%}
        <ul class="submenu">{{ loop(item.children) }}</ul>
    {%- endif %}</li>
{%- endfor %}
</ul>
# The loop variable always refers to the closest (innermost) loop. If we have more than one level of loops, we can rebind the variable loop by writing {% set outer_loop = loop %} after the loop that we want to use recursively. Then, we can call it using {{ outer_loop(…) }}

# Please note that assignments in loops will be cleared at the end of the iteration and cannot outlive the loop scope. Older versions of Jinja2 had a bug where in some circumstances it appeared that assignments would work. This is not supported. See Assignments for more information about how to deal with this.

# If all you want to do is check whether some value has changed since the last iteration or will change in the next iteration, you can use previtem and nextitem:

{% for value in values %}
    {% if loop.previtem is defined and value > loop.previtem %}
        The value just increased!
    {% endif %}
    {{ value }}
    {% if loop.nextitem is defined and loop.nextitem > value %}
        The value will increase even more!
    {% endif %}
{% endfor %}
If you only care whether the value changed at all, using changed is even easier:

{% for entry in entries %}
    {% if loop.changed(entry.category) %}
        <h2>{{ entry.category }}</h2>
    {% endif %}
    <p>{{ entry.message }}</p>
{% endfor %}


---------------------------If-------------------------------------------
The if statement in Jinja is comparable with the Python if statement. In the simplest form, you can use it to test if a variable is defined, not empty and not false:

{% if users %}
<ul>
{% for user in users %}
    <li>{{ user.username|e }}</li>
{% endfor %}
</ul>
{% endif %}
For multiple branches, elif and else can be used like in Python. You can use more complex Expressions there, too:

{% if kenny.sick %}
    Kenny is sick.
{% elif kenny.dead %}
    You killed Kenny!  You bastard!!!
{% else %}
    Kenny looks okay --- so far
{% endif %}
If can also be used as an inline expression and for loop filtering.

---------------------------------Macros-------------------------------
Macros are comparable with functions in regular programming languages. They are useful to put often used idioms into reusable functions to not repeat yourself (“DRY”).

Here’s a small example of a macro that renders a form element:

{% macro input(name, value='', type='text', size=20) -%}
    <input type="{{ type }}" name="{{ name }}" value="{{
        value|e }}" size="{{ size }}">
{%- endmacro %}
The macro can then be called like a function in the namespace:

<p>{{ input('username') }}</p>
<p>{{ input('password', type='password') }}</p>
If the macro was defined in a different template, you have to import it first.

Inside macros, you have access to three special variables:

varargs
If more positional arguments are passed to the macro than accepted by the macro, they end up in the special varargs variable as a list of values.

kwargs
Like varargs but for keyword arguments. All unconsumed keyword arguments are stored in this special variable.

caller
If the macro was called from a call tag, the caller is stored in this variable as a callable macro.

Macros also expose some of their internal details. The following attributes are available on a macro object:

name-The name of the macro. {{ input.name }} will print input.
arguments-A tuple of the names of arguments the macro accepts.
defaults-A tuple of default values.
catch_kwargs-This is true if the macro accepts extra keyword arguments (i.e.: accesses the special kwargs variable).
catch_varargs-This is true if the macro accepts extra positional arguments (i.e.: accesses the special varargs variable).
caller-This is true if the macro accesses the special caller variable and may be called from a call tag.

If a macro name starts with an underscore, it’s not exported and can’t be imported.

Call - in some cases it can be useful to pass a macro to another macro. For this purpose, you can use the special call block. The following example shows a macro that takes advantage of the call functionality and how it can be used:

{% macro render_dialog(title, class='dialog') -%}
    <div class="{{ class }}">
        <h2>{{ title }}</h2>
        <div class="contents">
            {{ caller() }}
        </div>
    </div>
{%- endmacro %}

{% call render_dialog('Hello World') %}
    This is a simple dialog rendered by using a macro and
    a call block.
{% endcall %}
# It’s also possible to pass arguments back to the call block. This makes it useful as a replacement for loops. Generally speaking, a call block works exactly like a macro without a name.

Here’s an example of how a call block can be used with arguments:

{% macro dump_users(users) -%}
    <ul>
    {%- for user in users %}
        <li><p>{{ user.username|e }}</p>{{ caller(user) }}</li>
    {%- endfor %}
    </ul>
{%- endmacro %}

{% call(user) dump_users(list_of_user) %}
    <dl>
        <dl>Realname</dl>
        <dd>{{ user.realname|e }}</dd>
        <dl>Description</dl>
        <dd>{{ user.description }}</dd>
    </dl>
{% endcall %}




--------------------------------------------------------------------
Filters
# Filter sections allow you to apply regular Jinja2 filters on a block of template data. Just wrap the code in the special filter section:

# {% filter upper %}
#     This text becomes uppercase
# {% endfilter %}
# Assignments
# Inside code blocks, you can also assign values to variables. Assignments at top level (outside of blocks, macros or loops) are exported from the template like top level macros and can be imported by other templates.

Assignments use the set tag and can have multiple targets:

# {% set navigation = [('index.html', 'Index'), ('about.html', 'About')] %}
# {% set key, value = call_something() %}
# Scoping Behavior
# Please keep in mind that it is not possible to set variables inside a block and have them show up outside of it. This also applies to loops. The only exception to that rule are if statements which do not introduce a scope. As a result the following template is not going to do what you might expect:

# {% set iterated = false %}
# {% for item in seq %}
#     {{ item }}
#     {% set iterated = true %}
# {% endfor %}
# {% if not iterated %} did not iterate {% endif %}
# It is not possible with Jinja syntax to do this. Instead use alternative constructs like the loop else block or the special loop variable:

# {% for item in seq %}
#     {{ item }}
# {% else %}
#     did not iterate
# {% endfor %}
# As of version 2.10 more complex use cases can be handled using namespace objects which allow propagating of changes across scopes:

# {% set ns = namespace(found=false) %}
# {% for item in items %}
#     {% if item.check_something() %}
#         {% set ns.found = true %}
#     {% endif %}
#     * {{ item.title }}
# {% endfor %}
# Found item having something: {{ ns.found }}
# Note hat the obj.attr notation in the set tag is only allowed for namespace objects; attempting to assign an attribute on any other object will raise an exception.

# New in version 2.10: Added support for namespace objects

Block Assignments
# Changelog
# Starting with Jinja 2.8, it’s possible to also use block assignments to capture the contents of a block into a variable name. This can be useful in some situations as an alternative for macros. In that case, instead of using an equals sign and a value, you just write the variable name and then everything until {% endset %} is captured.

# Example:

# {% set navigation %}
#     <li><a href="/">Index</a>
#     <li><a href="/downloads">Downloads</a>
# {% endset %}
# The navigation variable then contains the navigation HTML source.

# Changed in version 2.10.

# Starting with Jinja 2.10, the block assignment supports filters.

# Example:

# {% set reply | wordwrap %}
#     You wrote:
#     {{ message }}
# {% endset %}
Extends
# The extends tag can be used to extend one template from another. You can have multiple extends tags in a file, but only one of them may be executed at a time.

# See the section about Template Inheritance above.

Blocks
# Blocks are used for inheritance and act as both placeholders and replacements at the same time. They are documented in detail in the Template Inheritance section.

Include
The include statement is useful to include a template and return the rendered contents of that file into the current namespace:

{% include 'header.html' %}
    Body
{% include 'footer.html' %}
Included templates have access to the variables of the active context by default. For more details about context behavior of imports and includes, see Import Context Behavior.

# From Jinja 2.2 onwards, you can mark an include with ignore missing; in which case Jinja will ignore the statement if the template to be included does not exist. When combined with with or without context, it must be placed before the context visibility statement. Here are some valid examples:

{% include "sidebar.html" ignore missing %}
{% include "sidebar.html" ignore missing with context %}
{% include "sidebar.html" ignore missing without context %}
Changelog
# You can also provide a list of templates that are checked for existence before inclusion. The first template that exists will be included. If ignore missing is given, it will fall back to rendering nothing if none of the templates exist, otherwise it will raise an exception.
Example:
{% include ['page_detailed.html', 'page.html'] %}
{% include ['special_sidebar.html', 'sidebar.html'] ignore missing %}

Changelog
Import
# Jinja2 supports putting often used code into macros. These macros can go into different templates and get imported from there. This works similarly to the import statements in Python. It’s important to know that imports are cached and imported templates don’t have access to the current template variables, just the globals by default. For more details about context behavior of imports and includes, see Import Context Behavior.

There are two ways to import templates. You can import a complete template into a variable or request specific macros / exported variables from it.

Imagine we have a helper module that renders forms (called forms.html):

{% macro input(name, value='', type='text') -%}
    <input type="{{ type }}" value="{{ value|e }}" name="{{ name }}">
{%- endmacro %}

{%- macro textarea(name, value='', rows=10, cols=40) -%}
    <textarea name="{{ name }}" rows="{{ rows }}" cols="{{ cols
        }}">{{ value|e }}</textarea>
{%- endmacro %}
The easiest and most flexible way to access a template’s variables and macros is to import the whole template module into a variable. That way, you can access the attributes:

{% import 'forms.html' as forms %}
<dl>
    <dt>Username</dt>
    <dd>{{ forms.input('username') }}</dd>
    <dt>Password</dt>
    <dd>{{ forms.input('password', type='password') }}</dd>
</dl>
<p>{{ forms.textarea('comment') }}</p>
Alternatively, you can import specific names from a template into the current namespace:

{% from 'forms.html' import input as input_field, textarea %}
<dl>
    <dt>Username</dt>
    <dd>{{ input_field('username') }}</dd>
    <dt>Password</dt>
    <dd>{{ input_field('password', type='password') }}</dd>
</dl>
<p>{{ textarea('comment') }}</p>
Macros and variables starting with one or more underscores are private and cannot be imported.

Changelog
Import Context Behavior
By default, included templates are passed the current context and imported templates are not. The reason for this is that imports, unlike includes, are cached; as imports are often used just as a module that holds macros.

# This behavior can be changed explicitly: by adding with context or without context to the import/include directive, the current context can be passed to the template and caching is disabled automatically.

Here are two examples:

{% from 'forms.html' import input with context %}
{% include 'header.html' without context %}
Note
In Jinja 2.0, the context that was passed to the included template did not include variables defined in the template. As a matter of fact, this did not work:

{% for box in boxes %}
    {% include "render_box.html" %}
{% endfor %}
The included template render_box.html is not able to access box in Jinja 2.0. As of Jinja 2.1, render_box.html is able to do so.

Expressions
# Jinja allows basic expressions everywhere. These work very similarly to regular Python; even if you’re not working with Python you should feel comfortable with it.

Literals
# The simplest form of expr
“Hello World”:
# Everything between two double or single quotes is a string. They are useful whenever you need a string in the template (e.g. as arguments to function calls and filters, or just to extend or include a template).

42 / 42.23:
Integers and floating point numbers are created by just writing the number down. If a dot is present, the number is a float, otherwise an integer. Keep in mind that, in Python, 42 and 42.0 are different (int and float, respectively).

[‘list’, ‘of’, ‘objects’]:
Everything between two brackets is a list. Lists are useful for storing sequential data to be iterated over. For example, you can easily create a list of links using lists and tuples for (and with) a for loop:

<ul>
{% for href, caption in [('index.html', 'Index'), ('about.html', 'About'),
                         ('downloads.html', 'Downloads')] %}
    <li><a href="{{ href }}">{{ caption }}</a></li>
{% endfor %}
</ul>
(‘tuple’, ‘of’, ‘values’):
Tuples are like lists that cannot be modified (“immutable”). If a tuple only has one item, it must be followed by a comma (('1-tuple',)). Tuples are usually used to represent items of two or more elements. See the list example above for more details.

{‘dict’: ‘of’, ‘key’: ‘and’, ‘value’: ‘pairs’}:
A dict in Python is a structure that combines keys and values. Keys must be unique and always have exactly one value. Dicts are rarely used in templates; they are useful in some rare cases such as the xmlattr() filter.

true / false:
# true is always true and false is always false.

Note
# The special constants true, false, and none are indeed lowercase. Because that caused confusion in the past, (True used to expand to an undefined variable that was considered false), all three can now also be written in title case (True, False, and None). However, for consistency, (all Jinja identifiers are lowercase) you should use the lowercase versions.

Math
# Jinja allows you to calculate with values. This is rarely useful in templates but exists for completeness’ sake. The following operators are supported:

+
# Adds two objects together. Usually the objects are numbers, but if both are strings or lists, you can concatenate them this way. This, however, is not the preferred way to concatenate strings! For string concatenation, have a look-see at the ~ operator. {{ 1 + 1 }} is 2.

-
# Subtract the second number from the first one. {{ 3 - 2 }} is 1.

/
# Divide two numbers. The return value will be a floating point number. {{ 1 / 2 }} is {{ 0.5 }}.

//
# Divide two numbers and return the truncated integer result. {{ 20 // 7 }} is 2.

%
# Calculate the remainder of an integer division. {{ 11 % 7 }} is 4.

*
# Multiply the left operand with the right one. {{ 2 * 2 }} would return 4. This can also be used to repeat a string multiple times. {{ '=' * 80 }} would print a bar of 80 equal signs.

**
# Raise the left operand to the power of the right operand. {{ 2**3 }} would return 8.

Comparisons
==
# Compares two objects for equality.

!=
# Compares two objects for inequality.

>
# true if the left hand side is greater than the right hand side.

>=
# true if the left hand side is greater or equal to the right hand side.

<
# true if the left hand side is lower than the right hand side.

<=
# true if the left hand side is lower or equal to the right hand side.

Logic
# For if statements, for filtering, and if expressions, it can be useful to combine multiple expressions:

and
# Return true if the left and the right operand are true.

or
# Return true if the left or the right operand are true.

not
# negate a statement (see below).

(expr)
# group an expression.

Note
# The is and in operators support negation using an infix notation, too: foo is not bar and foo not in bar instead of not foo is bar and not foo in bar. All other expressions require a prefix notation: not (foo and bar).

Other Operators
# The following operators are very useful but don’t fit into any of the other two categories:

in
# Perform a sequence / mapping containment test. Returns true if the left operand is contained in the right. {{ 1 in [1, 2, 3] }} would, for example, return true.

is
# Performs a test.

|
# Applies a filter.

~
# Converts all operands into strings and concatenates them.

# {{ "Hello " ~ name ~ "!" }} would return (assuming name is set to 'John') Hello John!.

()
# Call a callable: {{ post.render() }}. Inside of the parentheses you can use positional arguments and keyword arguments like in Python:

{{ post.render(user, full=true) }}.

. / []
# Get an attribute of an object. (See Variables)

If Expression
# It is also possible to use inline if expressions. These are useful in some situations. For example, you can use this to extend from one template if a variable is defined, otherwise from the default layout template:

{% extends layout_template if layout_template is defined else 'master.html' %}
The general syntax is <do something> if <something is true> else <do something else>.

The else part is optional. If not provided, the else block implicitly evaluates into an undefined object:

{{ "[{}]".format(page.title) if page.title }}



Python Methods
You can also use any of the methods of defined on a variable’s type. The value returned from the method invocation is used as the value of the expression. Here is an example that uses methods defined on strings (where page.title is a string):

{{ page.title.capitalize() }}
This also works for methods on user-defined types. For example, if variable f of type Foo has a method bar defined on it, you can do the following:

{{ f.bar() }}