class node {
	public:
		int data;
		node* next;
		
		node() {
			data = 0;
			next = NULL;
		}

		node(int x) {
			data = x;
			next = NULL;
		}
};

class circular {
	public:
		node *head;
		int addfront(node *n);
		int isempty();
		int addatend(node *n);
		node *search(int k);
		node *deletenode(int x);

		circular() {
			head = NULL;
		}
};

int circular::addfront(node *n) {
	int i = 0;
	if(head == NULL) {
		n->next = head;
		head = n;
		i++;
	}

	else {
		n->next = head;
		node* last = getlast();
		last->next = n;
		head = n;
		i++;
	}

	return i;
}

/* insertion at last
 * if head is null, n.next is null
 * else, last.next = n
 * n.next = head */

/* searchign for an element x
 * ptr = head
 * while ptr is not null AND ptr.data is not x 
 * ptr = ptr.next 
 * return ptr*/

/* deleting a node n
 * if it's the first node, set head.next to n.next
 * update last.next to point to new head
 * if node is in the middle, find it's pos and make its
 * prev node point to next node
 * if node is at the end, remove it and make the new last node point to head 
 * */

