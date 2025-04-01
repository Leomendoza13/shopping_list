import os
from flask import Flask, request

app = Flask(__name__)

@app.route('/', methods=['GET'])
def health_check():
    return 'OK', 200

@app.route('/add_item', methods=['POST'])
def add_item():
    item = request.form['item']
    return f'You added {item}'

@app.route('/delete_item', methods=['POST'])
def delete_item():
    item = request.form['item']
    return f'You deleted {item}'

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 8080))
    app.run(host='0.0.0.0', port=port, debug=False)