import os
from jinja2 import Environment, FileSystemLoader

J2_ENV = Environment(loader=FileSystemLoader(''), trim_blocks=True)

def render_template(data):
	custom_template = J2_ENV.get_template('templates/template.j2')
	rendered_data = custom_template.render(data)
	with open('/etc/nginx/nginx.conf', "w") as fname:
		fname.write(rendered_data)

if __name__ == "__main__":

	final_data = {}
	final_data['port'] = os.environ.get('PORT', '80')
	final_data['endpoint'] = os.environ.get('ENDPOINT', '/indexer')
	final_data['hasura_ip'] = os.environ.get('HASURA_IP', 'localhost')
	final_data['hasura_port'] = os.environ.get('HASURA_PORT', '8080')

	#write nginx from jinja2 template
	render_template(final_data)


