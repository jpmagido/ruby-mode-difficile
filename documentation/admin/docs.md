- Admin can submit a new Doc
- Admin can Update existing Doc
- Doc have FR & EN content

ROUTES:

- namespace: `staff`
- `new_staff_doc_path`
- `edit_staff_doc_path`
- `staff_docs_path #POST`
- `staff_doc_path #PATCH` 
- `staff_doc_path #DELETE`

OBJECTS:

- `Staff::DocsController`
- `Admin`
